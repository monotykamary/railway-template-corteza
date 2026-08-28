FROM docker.io/cortezaproject/corteza:2024.9.10@sha256:03624fb33b18b6375b33c27a04ee01e2a9ae363c7592e9c86669125722733bb0
COPY entrypoint.sh /usr/local/bin/corteza-railway-entrypoint
RUN chmod +x /usr/local/bin/corteza-railway-entrypoint
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/corteza-railway-entrypoint"]
