# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid' do
    user = User.new
    user.valid?
    expect(user.errors).to be_empty, 'User is valid without any attributes'
  end

  it 'name should be present' do
    user = User.new(name: 'Example User')
    expect(user).to be_valid, 'User with name should be valid'
  end

  it 'photo should be present' do
    user = User.new(photo: 'example.jpg')
    expect(user).to be_valid, 'User with photo should be valid'
  end

  it 'bio should be present' do
    user = User.new(bio: 'This is a sample bio.')
    expect(user).to be_valid, 'User with bio should be valid'
  end

  it 'postCounter should be greater than or equal to 0' do
    user = User.new(postCounter: 0)
    expect(user).to be_valid, 'User with postCounter equal to 0 should be valid'

    user.postCounter = -1
    expect(user).not_to be_valid, 'User with negative postCounter should not be valid'
  end
end
