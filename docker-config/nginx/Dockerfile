FROM nginx:1.16

MAINTAINER steven "steven@zerologix.com"

# set timezome
ENV TZ=Australia/Sydney
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install Supervisor.
RUN \
  apt-get update && \
  apt-get install -y acl && \
  apt-get install -y procps && \
  apt-get install -y vim && \
  apt-get install -y curl && \
  apt-get install -y net-tools

  rm -rf /var/lib/apt/lists/*


ADD  nginx.conf  /etc/nginx/nginx.conf
ADD  conf.d/*  /etc/nginx/conf.d/
RUN  mkdir -p /data/wwwroot && mkdir -p /data/wwwlogs
RUN  chown -R www-data.www-data /data/wwwlogs
COPY ./nginx.conf /etc/nginx/

# Define working directory.
WORKDIR /etc/nginx

# Expose ports.

EXPOSE 80
EXPOSE 443
EXPOSE 8080
EXPOSE 8081

