require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Mission Impossible', text: 'Fallout') }
  let(:comment) { Comment.create(author: user, post:, text: 'MI7 first part is released.') }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is not valid without text' do
    comment.text = nil
    expect(comment).not_to be_valid
  end

  it "increments post's comments_counter after saving" do
    expect do
      post.comments.create(author: user, text: 'hello')
    end.to change { post.reload.comments_counter }.by(1)
  end

  it 'updates the comments counter on comment deletion' do
    comment.save
    expect { comment.destroy }.to change { post.reload.comments_counter }.by(-1)
  end
end
