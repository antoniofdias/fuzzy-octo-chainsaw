class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
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
    MovieCreatorWorker.perform_async(movie_data.as_json)
    redirect_to movies_path, notice: "Movies will be created in the background."
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
