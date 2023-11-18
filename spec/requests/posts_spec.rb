require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }

  describe 'GET /index' do
    it 'returns http success' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include("Here is a list of posts from #{user.name}")
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include("Here is #{user.name} Post")
      expect(response.body).to include(post.title)
      expect(response.body).to include(post.text)
    end
  end
end
