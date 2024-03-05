class MovieCreatorService
  def self.create_movies(movie_data)
    movie_data.each do |attributes|
      Movie.create(attributes)
    end
  end
end
