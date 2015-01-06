def application_event_controller_spec(event_type, create_method = :create)
  event_type_string = event_type.to_s
  event_name = "#{event_type_string}_event"
  event_symbol = event_name.to_sym
  event_class = event_name.classify.constantize
  controller_name = "Api::V1::#{event_type_string.capitalize}EventsController"
  controller_class = controller_name.classify.constantize
  representer_name = "Api::V1::#{event_type_string.capitalize}EventRepresenter"
  representer_class = representer_name.classify.constantize

  describe controller_class, :type => :controller, :api => true, :version => :v1 do

    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:identifier) { FactoryGirl.create(:identifier,
                          application: platform.application) }
    let!(:platform_access_token) { FactoryGirl.create(:access_token,
                                     application: platform.application) }
    let!(:access_token) { FactoryGirl.create(:access_token) }
    let!(:task)  { FactoryGirl.build(:task,
                                     person: identifier.resource_owner,
                                     platform: platform) }
    let!(:event) { FactoryGirl.build(event_symbol, task: task) }
    let!(:valid_json) { representer_class.new(event).to_json }

    context 'success' do
      it 'should be creatable by a platform app with a client credentials token if it has all required fields' do
        c = event_class.count
        api_post create_method, platform_access_token,
                 raw_post_data: valid_json
        expect(response.status).to eq(201)

        expect(event_class.count).to eq(c + 1)
        new_event = event_class.last
        expected_response = representer_class.new(new_event).to_json
        expect(response.body).to eq(expected_response)
        expect(new_event.task.platform).to eq(event.task.platform)
        expect(new_event.task.person).to eq(event.task.person)
        expect(new_event.task.resource.url).to eq(event.task.resource.url)
        expect(new_event.task.trial).to eq(event.task.trial)
      end
    end

    context 'authorization error' do
      it 'should not be creatable by a user with an identifier' do
        c = event_class.count
        expect{api_post create_method, identifier,
                        raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable by a non-platform app' do
        c = event_class.count
        expect{api_post create_method, access_token,
                        raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable with an invalid access token' do
        identifier.token = '0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF'
        c = event_class.count
        expect{api_post create_method, identifier,
                        raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable without an access token' do
        c = event_class.count
        expect{api_post create_method, nil,
                        raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end
    end

    context 'validation error' do
      it 'should not be creatable without a resource' do
        event.task.resource = nil
        c = event_class.count
        api_post create_method, platform_access_token,
                 raw_post_data: representer_class.new(event).to_json
        expect(response.status).to eq(422)

        errors = JSON.parse(response.body)
        expect(errors.first['offending_inputs']).to eq('resource')
        expect(errors.first['code']).to eq('blank')
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable without a trial' do
        event.task.trial = nil
        c = event_class.count
        api_post create_method, platform_access_token,
                 raw_post_data: representer_class.new(event).to_json
        expect(response.status).to eq(422)

        errors = JSON.parse(response.body)
        expect(errors.first['offending_inputs']).to eq('trial')
        expect(errors.first['code']).to eq('blank')
        expect(event_class.count).to eq(c)
      end
    end

    yield if block_given?

  end
end
