require 'rails_helper'
require 'webmock/rspec'

describe "Grading Events Retry Explosion", :type => :request, :api => true, :version => :v1 do

  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:identifier) { FactoryGirl.create(:identifier, platform: platform) }
  let!(:platform_access_token) { FactoryGirl.create(:access_token,
                                   application: platform.application) }
  let!(:task)  { FactoryGirl.build(:task, identifier: identifier) }
  let!(:event) { FactoryGirl.build(:grading_event, task: task) }

  it 'does not explode on a transaction retry' do

    # Using JSON borrowed from a real request, just in case (tho actually might not matter)
    json = {
      "identifier"=>"#{identifier.write_access_token.token}",
      "resource"=>"https://exercises.openstax.org/exercises/4623@1",
      "trial"=>"151379",
      "grade"=>1,
      "grader"=>"tutor",
      "format"=>"json",
      "controller"=>"api/v1/grading_events",
      "action"=>"create",
      "grading_event"=>{"grader"=>"tutor", "grade"=>1}
    }.to_json

    stub_request(:get, "https://exercises.openstax.org/exercises/4623@1").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "", :headers => {})

    # To get the transaction to retry (and to simulate what happens in production),
    # we need to raise an exception the first time through after the event has been
    # set in the routine outputs.  I picked a call to BL to fake b/c it doesn't impact
    # the outcome.  On the first call, the BL call raises an exception that triggers
    # transaction_retry; on the second it doesn't.

    @times_called = 0
    allow(OpenStax::Biglearn::V1).to receive(:send_response) do
      @times_called += 1
      if @times_called == 1
        raise(::ActiveRecord::TransactionIsolationConflict, 'hi')
      end
    end

    # In reality, the Lev routine is the top-level transaction, but rspec has its own
    # transactions at the top, so we have to fake that the Lev routine transaction
    # is at the top.
    allow(ActiveRecord::Base).to receive(:tr_in_nested_transaction?) { false }

    do_not_rescue_exceptions do
      expect{
        api_post "/api/events/platforms/gradings", platform_access_token, raw_post_data: json
      }.not_to raise_error
    end
  end

end
