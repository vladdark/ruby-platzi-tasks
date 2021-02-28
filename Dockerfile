FROM ruby:2.5.8-buster

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y wkhtmltopdf nodejs yarn wget postgresql-client

RUN mkdir /app
RUN mkdir -p /unicorn/pids
RUN mkdir -p /unicorn/sockets
RUN mkdir -p /unicorn/log
RUN mkdir /tmp/rails-app

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install
RUN yarn add bootstrap jquery popper.js roboto-fontface


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]