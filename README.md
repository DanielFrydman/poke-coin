# README

This was a challenge where I had to built an entire application with some specific features.

This is a pokemon trade calculator where the users can buy and sell pokemons and follow wallet appreciation or depreciation accordingly to bitcoin real value.

<em>This theory is a playful construction for the context of the exercise and without direct application wait in the real world.</em>.

##### Deploy link for this application using [Render](https://render.com/):
https://poke-coin-7qjr.onrender.com
<br>
***This link is no longer working because my database from Render has expired (free version).***

##### Specific tasks to be implemented:
● Allow the investor to register the acquisition of new pokémons; \
● Allow the investor to register the sale of pokémons; \
● Allowing investors to monitor the appreciation/depreciation of their portfolio in USD; \
● Allow viewing the history of performed operations. \
● Deploy this application in some platform(Ex: Heroku, Vercel, Fly.io, Netlify, etc)

I also created a Github Pipeline to run all the created tests after each push.

##### API's used in this project:
[Pokemons](https://pokeapi.co/docs/v2) \
[Cryptocurrency](https://www.coinapi.io/) -> (API_KEY required)

##### Things you may want to cover:
* Ruby version: 3.2.0
* Rails version: 7.0.4 (With ImportMap)
* PostgreSQL version: 12

##### Gems used in this project:
###### For application:
[Pg](https://github.com/ged/ruby-pg) \
[Devise](https://github.com/heartcombo/devise) \
[Rest Client](https://github.com/rest-client/rest-client) \
[Mime Types](https://github.com/mime-types/ruby-mime-types) \
[Chartkick](https://github.com/ankane/chartkick) \
[Bootstrap](https://github.com/twbs/bootstrap-rubygem)

###### For tests:
[Factory Bot Rails](https://github.com/thoughtbot/factory_bot_rails) \
[Byebug](https://github.com/deivid-rodriguez/byebug) \
[Faker](https://github.com/faker-ruby/faker) \
[Rspec Rails](https://github.com/rspec/rspec-rails) \
[Rspec Expectations](https://github.com/rspec/rspec-expectations) \
[Guard Rspec](https://github.com/guard/guard-rspec) \
[VCR](https://github.com/vcr/vcr) \
[Webmock](https://github.com/bblimke/webmock)

##### Want to run in your machine?
You will find a file named `app.example.yml` and another named `database.example.yml`. \
Just copy and paste those two and remove `.example` from the name to turn into `app.yml` and `database.yml`. \
This is because the configurations will change accordingly to each person system. \
After that you will need a Coin Api Key that you can request in their website and put into `app.yml`. \
Then you will have to config you `database.yml` with your user and password, if needed, and to config PostgreSQL. \
Run `bundle install`, `rails db:create db:migrate` and you're done(If you don't have any problems with your database).
