class MovieCreatorWorker
  include Sidekiq::Worker

  def perform(movie_data)
    MovieCreatorService.create_movies(movie_data)
  end
end
