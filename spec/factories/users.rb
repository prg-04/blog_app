FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    bio { 'Lorem ipsum dolor sit amet.' }
    postCounter { 0 }
  end
end
