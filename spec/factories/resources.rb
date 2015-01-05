# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
    transient do
      url nil
      links_count { url.nil? ? 2 : 0 }
    end

    after(:build) do |resource, evaluator|
      resource.links << FactoryGirl.build(
        :link, resource: resource, href: evaluator.url
      ) unless evaluator.url.nil?

      evaluator.links_count.times do
        resource.links << FactoryGirl.build(:link, resource: resource)
      end
    end
  end
end
