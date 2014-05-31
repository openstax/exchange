FactoryGirl.define do
  factory :user do
    openstax_accounts_user

    trait :admin do
      is_admin true
    end

    trait :terms_agreed do
      after(:create) do |user, evaluator|
        FinePrint::Contract.all.each do |contract|
          FinePrint.sign_contract(user, contract)
        end
      end
    end
  end
end
