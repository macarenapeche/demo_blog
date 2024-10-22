require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { Post.create(title: 'Sample Post', content: 'This is a sample post content.') }
  let(:valid_attributes) { { name: 'John Doe', content: 'This is a comment.', post: post } }

  describe 'associations' do
    it 'belongs to a post' do
      comment = Comment.new(valid_attributes)
      expect(comment.post).to eq(post)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = Comment.new(valid_attributes)
      expect(comment).to be_valid
    end

    it 'is not valid without a name' do
      comment = Comment.new(name: '', content: 'This is a comment', post: post)
      expect(comment).not_to be_valid
      expect(comment.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without content' do
      comment = Comment.new(name: 'John Doe', content: '', post: post)
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("can't be blank")
    end
  end
end
