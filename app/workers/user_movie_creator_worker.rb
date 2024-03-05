class UserMovieCreatorWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(user_id, movie_data)
    UserMovieCreatorService.rate_movies(user_id, movie_data)
  end
end
