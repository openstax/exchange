FactoryGirl.define do
  factory :user do
    openstax_accounts_account

    trait :admin do
      role 'admin'
    end

    trait :agent do
      role 'agent'
    end

    trait :researcher do
      role 'researcher'
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
