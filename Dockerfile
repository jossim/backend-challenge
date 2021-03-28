FROM ubuntu:20.10
RUN apt -y update
RUN apt install -y curl wget vim
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub |  apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' |  tee /etc/apt/sources.list.d/google-chrome.list
RUN apt -y update
RUN apt install -y ruby-full nodejs yarn vim google-chrome-stable postgresql-client libpq-dev build-essential
VOLUME ["/opt/app"]
WORKDIR "/opt/app"
RUN gem install rexml bundler
ADD Gemfile /opt/app/Gemfile
# ADD Gemfile.lock /opt/app/Gemfile.lock
RUN bundle install
EXPOSE 3000
EXPOSE 3035
CMD /opt/app/start.sh