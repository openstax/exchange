FactoryGirl.define do 
  factory :exchanger do 

    ignore do
      api_keys_count 1
    end

    factory :exchanger_with_api_keys do
      after(:create) do |exchanger, evaluator|
        FactoryGirl.create_list(:api_key, evaluator.api_keys_count, exchanger: exchanger)
      end
    end
  end
end