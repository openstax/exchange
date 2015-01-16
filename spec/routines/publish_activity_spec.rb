require 'rails_helper'

RSpec.describe PublishActivity do

  let!(:exercise_activity) { FactoryGirl.create :exercise_activity }

  it 'fails if AWS credentials are not set' do
    Aws.config[:credentials] = Aws::Credentials.new(nil, nil)

    errors = PublishActivity.call(exercise_activity, stub_responses: true)
                            .errors
    expect(errors.first.code).to eq :aws_credentials_blank
  end

  it 'sends Activities to Amazon SNS' do
    Aws.config[:credentials] = Aws::Credentials.new('dummy_access_key_id',
                                                    'dummy_secret_access_key')

    routine = PublishActivity.call(exercise_activity, stub_responses: true)
    expect(routine.errors).to be_empty
    expect(routine.outputs[:result][:message_id]).to eq 'messageId'
  end

end
