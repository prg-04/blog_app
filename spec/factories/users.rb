FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    bio { 'Lorem ipsum dolor sit amet.' }
    postsCounter { 0 }
  end
end
