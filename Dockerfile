FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build main.go


FROM debian:11-slim AS release_candidate
ENV TZ=Europe/Amsterdam
RUN apt-get update && apt-get install -y --no-install-recommends -y ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root
COPY --from=builder  /root/main /root/x-ui
COPY bin/. /root/bin/.

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]

VOLUME [ "/etc/x-ui" ]
CMD [ "./x-ui" ]
