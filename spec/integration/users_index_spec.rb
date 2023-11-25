require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'yaml'

describe 'testing users/index', type: :feature do
  before(:each) do
    # Load users from the YAML file
    users_data = YAML.load_file(Rails.root.join('spec', 'fixtures', 'users.yml'))

    # Create users from the loaded data
    users_data.each do |_user_key, user_data|
      User.create(user_data)
    end

    visit users_path
  end

  it 'should see the username of all the users' do
    expect(page).to have_content('Tom Cruise')
    expect(page).to have_content('Mel Gibson')
    expect(page).to have_content('Russel Crowe')
  end

  it 'should see the profile picture for each user' do
    expect(page).to have_css("img[src*='https://example.com/tom.jpg']")
    expect(page).to have_css("img[src*='https://example.com/gibson.jpg']")
    expect(page).to have_css("img[src*='https://example.com/russel.jpg']")
  end

  it 'should see the number of posts each user has written' do
    expect(page).to have_content 'Number of posts: 0'
    expect(page).to have_content 'Number of posts: 3'
    expect(page).to have_content 'Number of posts: 2'
  end

  it 'should be redirected to a user\'s show page upon clicking on the user' do
    click_on 'Russel Crowe'
    expect(page).to have_current_path user_path(User.find_by(name: 'Russel Crowe').id)
  end
end
