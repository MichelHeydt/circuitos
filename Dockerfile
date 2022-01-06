FROM ruby:2.7.2-slim-buster

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

WORKDIR /app/

COPY . ./

RUN echo "America/Sao_Paulo" > /etc/timezone && \
rm -f /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata && \
apt-get update -y && \
       apt-get install -y --assume-yes --no-install-recommends --no-install-suggests \
        git wget curl unzip build-essential && \
 wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
 dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install && \
   CHROMEDRIVER_VERSION="90.0.4430.24" && \
   mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
   curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
   unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
   rm /tmp/chromedriver_linux64.zip && \
   chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
   ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver && \
gem install bundler -v 2.2.15 && bundle install -j5 --retry 3 && \
apt-get purge --assume-yes --auto-remove \
    --option APT::AutoRemove::RecommendsImportant=false \
    --option APT::AutoRemove::SuggestsImportant=false && \
    rm -rf /var/lib/apt/lists/*