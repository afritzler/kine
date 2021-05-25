FROM golang:1.16.3 AS builder

# build kine
WORKDIR /kine
COPY . .
ENV GO111MODULE=on
RUN ./scripts/build

# install etcd & etcdctl
ENV ETCD_VER=v3.5.0-beta.3
# choose either URL
ENV GOOGLE_URL=https://storage.googleapis.com/etcd
ENV GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
ENV DOWNLOAD_URL=${GOOGLE_URL}

RUN curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/ --strip-components=1

# /tmp/etcd --version
# /tmp/etcdctl version
# /tmp/etcdutl version

FROM alpine:latest

WORKDIR /

COPY --from=builder /kine/bin/kine /bin/kine
COPY --from=builder /tmp/etcdctl /bin/etcdctl

EXPOSE 2379

CMD [ "/bin/kine" ]