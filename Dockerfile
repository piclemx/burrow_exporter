FROM golang:1.15.12-alpine3.13 as gobuild
WORKDIR /go/src/burrow_exporter
COPY . /go/src/burrow_exporter
RUN go clean
RUN go build -o exporter

FROM alpine
COPY --from=gobuild /go/src/burrow_exporter/exporter .
ENV BURROW_ADDR http://localhost:8000
ENV METRICS_ADDR 0.0.0.0:8080
ENTRYPOINT [ "./exporter" ]
CMD []
