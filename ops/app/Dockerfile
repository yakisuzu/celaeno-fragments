FROM adoptopenjdk/openjdk11:alpine-jre

RUN apk add --update --no-cache \
  tzdata \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && echo "Asia/Tokyo" > /etc/timezone \
  && apk del tzdata

ADD celaeno-fragments.jar .
ADD system_core.dic .
CMD ["java", "-jar", "celaeno-fragments.jar"]
