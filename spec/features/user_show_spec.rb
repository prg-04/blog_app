require 'rails_helper'

RSpec.feature 'Users page' do
  it 'displays a title and the list of users' do
    visit('/')
    expect(page).to have_content('Users')
  end
end
