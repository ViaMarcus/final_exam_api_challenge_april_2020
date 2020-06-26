RSpec.describe 'POST /api/comment, user can comment on an article' do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  let(:article) { create(:article) }

  describe 'successfully with valid credentials, article id and body' do
    before do
      post '/api/comments',
           headers: headers,
           params: { body: "This is the comment body", article: article.id }
    end

    it 'has a 201 response' do
      expect(response).to have_http_status 201
    end

    it 'has a success message' do
      expect(response_json['message']).to eq 'Comment successfully posted!'
    end

    it 'article then has the comment' do
      article.reload
      expect(article.comments.length).to eq 1
    end
  end

  describe 'unsuccessfully without headers' do
    before do
      post '/api/comments',
      params: { body: "This is the comment body", article: article.id }
    end

    it 'has a 401 response' do
      expect(response).to have_http_status 401
    end

    it 'has an error message' do
      expect(response_json['errors'][0]).to eq 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'unsuccessfully with missing params' do
    describe ':body' do
      before do
        post '/api/comments',
        params: { article: article.id }
      end

      it 'has a 422 response' do
        expect(response).to have_http_status 422
      end
  
      it 'has an error message' do
        expect(response_json['message']).to eq "Body can't be blank"
      end
    end

    describe ':body' do
      before do
        post '/api/comments',
        params: { article: article.id }
      end

      it 'has a 422 response' do
        expect(response).to have_http_status 422
      end
  
      it 'has an error message' do
        expect(response_json['message']).to eq "Unable to find article with an ID"
      end
    end
  end
end