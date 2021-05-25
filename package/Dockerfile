FROM alpine:3.12
ARG ARCH=amd64
COPY bin/kine /bin/kine
RUN mkdir /db && chown nobody /db
VOLUME /db
EXPOSE 2379/tcp
USER nobody
ENTRYPOINT ["/bin/kine"]
