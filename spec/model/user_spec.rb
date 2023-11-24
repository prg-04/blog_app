# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid' do
    user = build(:user)
    expect(user).to be_valid, 'User is not valid without any attributes'
  end

  it 'name should be present' do
    user = build(:user, name: nil)
    expect(user).not_to be_valid, 'User without name should not be valid'
  end

  it 'bio should be present' do
    user = build(:user, bio: nil)
    expect(user).not_to be_valid, 'User without bio should not be valid'
  end

  it 'postsCounter should be greater than or equal to 0' do
    user = build(:user, postsCounter: 0)
    expect(user).to be_valid, 'User with postCounter equal to 0 should be valid'

    user.postsCounter = -1
    expect(user).not_to be_valid, 'User with negative postCounter should not be valid'
  end
end
