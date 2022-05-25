# rails-search-engine-exercise

## Set up

Install rvm, `cd` into the root folder in a terminal and follow instructions to install ruby. Then `cd` into that folder again. That should create the gemset. The output of `rvm current` when opening a new terminal and stepping into the root folder should be:

`ruby-3.1.2@rails-search-engine-exercise`

Make sure that that's the case before executing any other command.

Then run `gem install bundler -v 2.3.14` and `bundle install` to fetch dependencies.

Check that sqlite is installed: `sqlite3 --version` should return a version number. Otherwise, install it.

Generate the env file: `cp .env.example .env`.

Sign up on [SerpApi](https://serpapi.com/#pricing) (there's a free plan).

Copy the API key and paste it as `SERPAPI_API_KEY` value in `.env`.

## Run the server

Run `rails server`

## Test the search endpoint

Search setting the `search_engine` to `google`, `bing` or `both` and `query` to the search query text.

For example: http://localhost:3000/search?search_engine=bing&query=ruby%20on%20rails
