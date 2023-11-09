FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    text { 'Sample Text' }
  end
end
