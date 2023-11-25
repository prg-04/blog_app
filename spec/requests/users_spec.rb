require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:sample_user_data) do
    {
      name: 'Tom Cruise',
      posts_counter: 0,
      bio: 'actor',
      photo: 'https://example.com/tom.jpg'
    }
  end
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the #index with user data' do
      user = User.create(sample_user_data)
      get users_path
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET #show' do
    let!(:user) { User.create(sample_user_data) }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include(user.name.to_s)
    end

    it 'handles invalid user parameters' do
      get user_path(12_345) # Provide a non-existent user ID
      expect(response).to redirect_to(users_path)
      expect(flash[:alert]).to eq('User not found')
    end
  end
end
