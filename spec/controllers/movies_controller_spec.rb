require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  fixtures :users, :movies

  let(:user) { users(:one) }
  let(:valid_movie_params) { { title: 'Suicide Squad', director: 'James Gunn' } }
  let(:invalid_movie_params) { { title: nil, director: 'Christopher Nolan' } }

  describe 'GET #index' do
    it 'assigns @movies' do
      get :index, params: { user_id: user.id }
      expect(assigns(:movies)).to eq([movies(:dune), movies(:inception)])
    end

    it 'renders the index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template('index')
    end

    it 'renders JSON with average_score' do
      get :index, params: { user_id: user.id, format: :json }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]).to have_key('average_score')
    end
  end

  describe 'GET #new' do
    it 'assigns a new movie to @movie' do
      get :new, params: { user_id: user.id }
      expect(assigns(:movie)).to be_a_new(Movie)
    end

    it 'renders the new template' do
      get :new, params: { user_id: user.id }
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new movie' do
        expect {
          post :create, params: { movie: valid_movie_params, user_id: user.id }
        }.to change(Movie, :count).by(1)
      end

      it 'redirects to the movies index' do
        post :create, params: { movie: valid_movie_params, user_id: user.id }
        expect(response).to redirect_to(movies_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new movie' do
        expect {
          post :create, params: { movie: invalid_movie_params, user_id: user.id }
        }.not_to change(Movie, :count)
      end

      it 'renders the new template' do
        post :create, params: { movie: invalid_movie_params, user_id: user.id }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'POST #create_multiple' do
    context 'with valid parameters' do
      before { allow(MovieCreatorWorker).to receive(:create).and_return( success: "successful") }

      it 'responds with status :ok' do
        post :create_multiple, params: { movie_data: [{ title: 'Movie1', director: 'Director1' }],
                                         user_id: user.id, format: :json }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'responds with status :unprocessable_entity' do
        post :create_multiple, params: { movie_data: {}, user_id: user.id, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end