require 'rails_helper'

RSpec.describe MovieCreatorService, type: :service do
  describe '.create_movies' do
    let(:movie_data) do
      [
        { title: 'Inception', director: 'Christopher Nolan' },
        { title: 'Dune', director: 'Dennis Villenauve' },
        { title: 'Matrix', director: 'The Wachowskis' }
      ]
    end

    it 'creates movies with the given attributes' do
      expect {
        MovieCreatorService.create_movies(movie_data)
      }.to change(Movie, :count).by(movie_data.size)

      movie_data.each do |attributes|
        movie = Movie.find_by(attributes.symbolize_keys)
        expect(movie).to be_present
      end
    end

    it 'does not create movies with invalid attributes' do
      invalid_movie_data = [
        { title: 'Inception' }, # Missing director
        { director: 'Christopher Nolan' } # Missing title
      ]

      expect {
        MovieCreatorService.create_movies(invalid_movie_data)
      }.not_to change(Movie, :count)
    end
  end
end
