class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def rate_multiple
    user_id = current_user.id
    movie_data = params.require(:movie_data).map { |movie| movie.permit(:score, :movie_id).to_h }
    UserMovieCreatorWorker.perform_async(user_id, movie_data.as_json)
    redirect_to movies_path, notice: "Movies will be rated in the background."
  end  
end
