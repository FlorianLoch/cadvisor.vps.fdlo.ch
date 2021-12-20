FROM gcr.io/cadvisor/cadvisor:v0.43.0

# Dokku will pick this up
EXPOSE 8080

CMD [ "--docker_only", \
      "--housekeeping_interval=10s", \
      "--max_housekeeping_interval=60s" ]
