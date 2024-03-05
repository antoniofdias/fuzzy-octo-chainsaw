class UserMovieCreatorService
  def self.rate_movies(user_id, movie_data)
    user = User.find(user_id)
    movie_data.each do |attributes|
      rate_movie(user, attributes.symbolize_keys)
    end
  end

  def self.rate_movie(user, attributes)
    user_movie = user.user_movies.find_by(id: attributes[:movie_id])
    if user_movie.nil?
      movie = Movie.find(attributes[:movie_id])
      user.movies << movie
      user_movie = user.user_movies.find_by(movie_id: movie.id)
    end
    user_movie.update(score: attributes[:score])
  end
end
