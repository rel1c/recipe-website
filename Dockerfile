FROM httpd:latest
MAINTAINER Adam Peterson ajay2828@gmail.com
COPY ./site/ /usr/local/apache2/htdocs/
COPY ./bin/ /usr/local/bin/

WORKDIR /usr/local/apache2/htdocs/

RUN apt-get update && \
    apt-get install -y pandoc && \
    gen-html-recipes.sh && \
    gen-links.sh && \
    apt-get remove -y pandoc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80
