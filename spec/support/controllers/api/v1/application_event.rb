def application_event_controller_spec(event_type)
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
    let!(:identifier) { FactoryGirl.create(:identifier, application: platform.application) }
    let!(:platform_access_token) { FactoryGirl.create(:access_token,
                                                      application: platform.application) }
    let!(:access_token) { FactoryGirl.create(:access_token) }
    let!(:event) { FactoryGirl.build(event_symbol, person: identifier.resource_owner) }
    let!(:valid_json) { representer_class.new(event)
                                         .to_json(requestor: platform.application) }

    context 'success' do
      it 'should be creatable by a platform app with a client credentials token if it has all required fields' do
        c = event_class.count
        api_post :create, platform_access_token, raw_post_data: valid_json
        expect(response.status).to eq(201)

        expect(event_class.count).to eq(c + 1)
        new_event = event_class.last
        expected_response = representer_class.new(new_event)
                              .to_json(requestor: platform.application)
        expect(response.body).to eq(expected_response)
        expect(new_event.resource.reference).to eq('MyResource')
        expect(new_event.attempt).to eq(42)
        expect(new_event.selector).to eq('#my_selector')
      end
    end

    context 'authorization error' do
      it 'should not be creatable by a user with an identifier' do
        c = event_class.count
        expect{api_post :create, identifier, raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable by a non-platform app' do
        c = event_class.count
        expect{api_post :create, access_token, raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable with an invalid access token' do
        identifier.token = '0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF'
        c = event_class.count
        expect{api_post :create, identifier, raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable without an access token' do
        c = event_class.count
        expect{api_post :create, nil, raw_post_data: valid_json}.to(
          raise_error(SecurityTransgression))
        expect(event_class.count).to eq(c)
      end
    end

    context 'validation error' do
      it 'should not be creatable without an attempt' do
        event.attempt = nil
        c = event_class.count
        api_post :create, platform_access_token,
                 raw_post_data: representer_class.new(event)
                                                 .to_json(requestor: platform.application)
        expect(response.status).to eq(422)

        expected_response = {attempt: ['can\'t be blank']}.stringify_keys
        expect(JSON.parse(response.body)).to eq(expected_response)
        expect(event_class.count).to eq(c)
      end

      it 'should not be creatable without a resource' do
        event.resource = nil
        c = event_class.count
        api_post :create, platform_access_token,
                 raw_post_data: representer_class.new(event)
                                                 .to_json(requestor: platform.application)
        expect(response.status).to eq(422)

        expected_response = {resource: ['can\'t be blank']}.stringify_keys
        expect(JSON.parse(response.body)).to eq(expected_response)
        expect(event_class.count).to eq(c)
      end
    end

    yield if block_given?

  end
end
