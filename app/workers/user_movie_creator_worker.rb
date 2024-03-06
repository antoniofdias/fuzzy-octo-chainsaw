class UserMovieCreatorWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def self.create(user_id, movie_data)
    UserMovieCreatorWorker.perform_async(movie_data.as_json)
    { sucess: "Movies will be created in the background." }
  end

  def perform(user_id, movie_data)
    UserMovieCreatorService.rate_movies(user_id, movie_data)
  end
end
