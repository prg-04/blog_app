# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is a list of all Users')
      # Add more checks for specific content as needed
    end
  end

  describe 'GET /show' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include("Here is a Single User (#{user.name})")
      expect(response.body).to include("Here is a list of posts for #{user.name}")
      # Add more checks for specific content as needed
    end
  end
end
