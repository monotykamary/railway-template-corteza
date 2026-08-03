FROM docker.io/cortezaproject/corteza:2024.9.9@sha256:a874696f3afcdbc70dfe480d1127b53bfdea47d230424ac71d11e2936950fc60
COPY entrypoint.sh /usr/local/bin/corteza-railway-entrypoint
RUN chmod +x /usr/local/bin/corteza-railway-entrypoint
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/corteza-railway-entrypoint"]
