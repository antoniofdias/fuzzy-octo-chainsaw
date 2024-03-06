### Ruby On Rails backend challenge:

#### Requirements:

- ruby-3.1.4
- sqlite3

Clone the project and when executing:

```ruby
bundle install
rails db:migrate
rails db:seed
```

An Rails application will be configured with the following features:

- Default user: admin@rotten, password: admin
- Login page
- Route to create new users
- Route to register a new movie
- Route to rate movies
- Display the average rating for each movie

Lastly, you will need to have a redis instance running (see the [docs](https://redis.io/docs/)), run sidekiq with the command `bundle exec sidekiq` and the rails server with `rails s -b 127.0.0.1`.

On the folder `test/requests` it is possible to visualize a few examples of the expected input on the created routes. The user can also create a massive json by running the `createMassiveJSON.py` python script located on the main folder.
