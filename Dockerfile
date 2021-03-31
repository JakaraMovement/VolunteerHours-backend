FROM ruby:2.6.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client vim
RUN yarn install --check-files
RUN yarn add bootstrap jquery popper.js

WORKDIR /VolunteerHours-backend
COPY Gemfile /VolunteerHours-backend/Gemfile
COPY Gemfile.lock /VolunteerHours-backend/Gemfile.lock
RUN gem install bundler:2.0.2
RUN bundle install
RUN rails webpacker:install

COPY . /VolunteerHours-backend

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
