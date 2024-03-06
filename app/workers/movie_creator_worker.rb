class MovieCreatorWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def self.create(movie_data)
    MovieCreatorWorker.perform_async(movie_data.as_json)
    { sucess: "Movies will be created in the background." }
  end

  def perform(movie_data)
    MovieCreatorService.create_movies(movie_data)
  end
end
