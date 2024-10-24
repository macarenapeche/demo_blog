require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:valid_attributes) { { title: 'Sample Post', content: 'This is a post.' } }

  describe 'validations' do
    it 'is valid with valid attributes' do
      post = Post.new(valid_attributes)
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(title: '', content: 'Sample Post')
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without content' do
      post = Post.new(title: 'Post Title', content: '')
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end
  end
end
