OpenStax Exchange
=================

[![Build Status](https://travis-ci.org/openstax/exchange.svg?branch=master)](https://travis-ci.org/openstax/exchange)
[![Code Climate](https://codeclimate.com/github/openstax/exchange.png)](https://codeclimate.com/github/openstax/exchange)
[![Coverage Status](https://img.shields.io/codecov/c/github/openstax/exchange.svg)](https://codecov.io/gh/openstax/exchange)

OpenStax Exchange stores and provides learner interaction "big data".

## Development Setup

In development, Exchange can be run as a normal Rails app on your machine. It uses binstubs.

### Running as a normal Rails app on your machine

To start running Exchange in a development environment, clone the repository, then

```
bundle install --without production
```

Just like with any Rails app, you then need to migrate the database.  In our case, after the first migration we also need to load the database seeds (placeholder terms of use, etc, that the code relies on):

You _may_ need to prefix your commands with `RAILS_ENV=development`

```
bin/rake db:migrate
bin/rake db:seed
```

or in one step

```
bin/rake db:setup
```

When you run

```
bin/rails server
```

Exchange will start up on port 3003, i.e. http://localhost:3003.
