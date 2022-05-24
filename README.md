# rails-search-engine-exercise

## Set up

Install rvm, `cd` into the root folder in a terminal and follow instructions to install ruby. Then `cd` into that folder again. That should create the gemset. The output of `rvm current` when opening a new terminal and stepping into the root folder should be:

`ruby-3.1.2@rails-search-engine-exercise`

Make sure that that's the case before executing any other command.

Then run `gem install bundler -v 2.3.14` and `bundle install` to fetch dependencies.

Check that sqlite is installed: `sqlite3 --version` should return a version number. Otherwise, install it.



