require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { user_id: user.id }
      expect(response).to be_successful
    end

    it 'assigns a new post to @post' do
      get :new, params: { user_id: user.id }
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new post' do
        post :create, params: { user_id: user.id, post: attributes_for(:post) }
        expect(response).to redirect_to(user_posts_path(user))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new post' do
        post :create, params: { user_id: user.id, post: attributes_for(:post, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post, user:) }

    it 'returns a successful response' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to be_successful
    end

    it 'assigns the requested post to @post' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end
end
