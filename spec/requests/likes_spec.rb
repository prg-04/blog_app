require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  describe 'POST #create' do
    it 'returns http success after successful like' do
      user = create(:user)
      post = create(:post, user:)

      post user_post_likes_path(user, post)
      expect(response).to have_http_status(:found) # HTTP 302 Found (Redirect)
    end
  end
end
