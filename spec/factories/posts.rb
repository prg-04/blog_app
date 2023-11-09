FactoryBot.define do
  factory :post do
    association :user, factory: :user
    title { 'Sample Title' }
    text { 'Sample Text' }
    commentsCounter { 0 }
    likesCounter { 0 }
  end
end
