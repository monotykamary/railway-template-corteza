FROM docker.io/cortezaproject/corteza:2026.9.0@sha256:46773468bac01f3da7631f222c594a6fa66e5d28b8c467bacf9ff236e35458f9
COPY entrypoint.sh /usr/local/bin/corteza-railway-entrypoint
RUN chmod +x /usr/local/bin/corteza-railway-entrypoint
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/corteza-railway-entrypoint"]
