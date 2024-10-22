require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:post_instance) { Post.create!(title: 'Sample Post', content: 'Post content') }
  let(:valid_comment_attributes) {
    { name: 'John Doe', content: 'This is a sample comment.' }
  }

  let(:invalid_comment_attributes) {
    { name: '', content: '' }
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new comment" do
        expect {
          post post_comments_path(post_instance), params: { comment: valid_comment_attributes }
        }.to change(post_instance.comments, :count).by(1)
      end

      it "redirects to the post show page with notice" do
        post post_comments_path(post_instance), params: { comment: valid_comment_attributes }
        expect(response).to redirect_to(post_path(post_instance))
        follow_redirect!
        expect(response.body).to include('Comment was successfully created.')
      end
    end

    context "with invalid parameters" do
      it "does not create a new comment" do
        expect {
          post post_comments_path(post_instance), params: { comment: invalid_comment_attributes }
        }.not_to change(post_instance.comments, :count)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:comment_instance) { post_instance.comments.create!(valid_comment_attributes) }

    it "destroys the requested comment" do
      expect {
        delete post_comment_path(post_instance, comment_instance)
      }.to change(post_instance.comments, :count).by(-1)
    end

    it "redirects to the post show page with notice" do
      delete post_comment_path(post_instance, comment_instance)
      expect(response).to redirect_to(post_path(post_instance))
      follow_redirect!
      expect(response.body).to include('Comment was successfully deleted.')
    end
  end
end
