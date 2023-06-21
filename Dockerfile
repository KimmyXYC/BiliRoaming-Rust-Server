FROM rust:latest AS builder
WORKDIR /tmp/builder/
COPY . .
RUN cargo build --profile=fast

FROM redis:latest
WORKDIR /app
COPY --from=builder /tmp/builder/target/fast/ .
COPY config.example.json config.json 
RUN mkdir web
VOLUME ["web", "config.json"]
EXPOSE 2662
ENV CONTAINER_NAME=biliroaming-rust-server
CMD ["./biliroaming_rust_server"]
