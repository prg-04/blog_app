require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'GET /users/:user_id/posts/:post_id/comments/new' do
    it 'returns http success' do
      user = create(:user)
      post = create(:post, user:)

      get "/users/#{user.id}/posts/#{post.id}/comments/new"
      expect(response).to have_http_status(:success)
    end
  end
end
