FROM crystallang/crystal:0.36.1-alpine-build as build-image

ENV MUSL_LOCPATH /usr/share/i18n/locales/musl
ENV MUSL_LOCALE_DEPS cmake make musl-dev gcc gettext-dev libintl

RUN apk add --no-cache --update \
    $MUSL_LOCALE_DEPS \
    && wget https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip \
    && unzip musl-locales-master.zip \
      && cd musl-locales-master \
      && cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && make && make install

WORKDIR /usr/local/
RUN git clone https://github.com/luckyframework/lucky_cli && \
  cd lucky_cli && \
  git checkout v0.26.0 --quiet && \
  shards install

WORKDIR /usr/local/lucky_cli
RUN crystal build src/lucky.cr -o /usr/local/bin/lucky

FROM crystallang/crystal:0.35.1-alpine as runtime-image

RUN apk add --no-cache --update postgresql-client
COPY --from=build-image /usr/local/bin/lucky /usr/local/bin/lucky
COPY --from=build-image /usr/share/i18n/locales/musl /usr/share/i18n/locales/musl

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

EXPOSE 5000
