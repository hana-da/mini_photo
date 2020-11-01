mini_photo
----------

# Requirements

What you'll need to verify that mini_photo works:

* Ruby 2.7.2
* Node.js/Yarn (for webpacker gem)
* SQLite 3.6.16 or later (for sqlite3 gem)
* GNU C++ compiler (for sassc gem)

See also the `Dockerfile`.  

# Setup and Trial
    
    $ git clone https://github.com/hana-da/mini_photo.git
    $ cd mini_photo
    $ yarn install --check-files
    $ bin/setup
    $ bin/rails runner 'puts SecureRandom.urlsafe_base64.tap { User.create(name: "someone", password: _1) }'
    $ bin/rails server

`db/seed.rb` is empty, so you should create User from `rails console` as you like.

## with Docker

if you use Docker:

    $ git clone https://github.com/hana-da/mini_photo.git
    $ cd mini_photo
    $ docker build . -t mini_photo
    $ docker run -it -p 3000:3000 -v $(pwd):/mini_photo mini_photo:latest bash
    # : inside docker container
    # yarn install --check-files
    # setup
    # rails runner 'puts SecureRandom.urlsafe_base64.tap { User.create(name: "someone", password: _1) }'
    # rails server -b 0.0.0.0

# Environment variables

The following environment variables are used in this application.

- MY_TWEET_APP_CLIENT_ID
- MY_TWEET_APP_CLIENT_SECRET
