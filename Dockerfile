FROM ruby:3.1-buster as ruby

RUN gem update --system && gem install json && gem install kramdown && gem cleanup

WORKDIR /src

COPY . .

CMD ["ruby", "ghost_to_jekyll.rb"]

