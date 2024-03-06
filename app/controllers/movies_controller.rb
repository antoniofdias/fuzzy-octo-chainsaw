class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all.to_a
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def create_multiple
    movie_data = params.require(:movie_data).map { |movie| movie.permit(:title, :director).to_h }
    response = MovieCreatorWorker.create(movie_data)
    respond_to do |format|
      format.json { render json: response.as_json, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: e.message, status: :unprocessable_entity }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
