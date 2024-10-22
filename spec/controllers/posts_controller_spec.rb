require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:valid_attributes) {
    { title: 'Sample Post', content: 'This is a sample post content.' }
  }

  let(:invalid_attributes) {
    { title: '', content: '' }
  }

  let!(:post_instance) { Post.create!(valid_attributes) }

  describe "GET /index" do
    it "renders a successful response" do
      get posts_path
      expect(response).to be_successful
      expect(assigns(:posts)).to eq([post_instance])
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_post_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post posts_path, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post with a notice" do
        post posts_path, params: { post: valid_attributes }
        expect(response).to redirect_to(post_url(Post.last))
        follow_redirect!
        expect(response.body).to include('Post was successfully created.')
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_path, params: { post: invalid_attributes }
        }.to change(Post, :count).by(0)
      end

      it "renders the 'new' template again" do
        post posts_path, params: { post: invalid_attributes }
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get post_path(post_instance)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_post_path(post_instance)
      expect(response).to be_successful
    end
  end

  describe "PUT /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { title: 'Updated Title', content: 'Updated content.' }
      }

      it "updates the requested post" do
        put post_path(post_instance), params: { post: new_attributes }
        post_instance.reload
        expect(post_instance.title).to eq('Updated Title')
        expect(post_instance.content).to eq('Updated content.')
      end

      it "redirects to the post with a notice" do
        put post_path(post_instance), params: { post: new_attributes }
        expect(response).to redirect_to(post_instance)
        follow_redirect!
        expect(response.body).to include('Post was successfully updated.')
      end
    end

    context "with invalid parameters" do
      it "renders the 'edit' template again" do
        put post_path(post_instance), params: { post: invalid_attributes }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      expect {
        delete post_path(post_instance)
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list with a notice" do
      delete post_path(post_instance)
      expect(response).to redirect_to(posts_url)
      follow_redirect!
      expect(response.body).to include('Post was successfully destroyed.')
    end
  end
end
