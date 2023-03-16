FROM ruby:3.1-buster as ruby

RUN gem update --system && gem install json && gem install kramdown && gem cleanup

WORKDIR /usr/local

COPY . .

ENTRYPOINT ["ruby", "./bin/ghost_to_jekyll"]

