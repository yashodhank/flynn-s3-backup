FROM alpine:3.4

RUN set -x && \

	# Install curl for flynn http api
	apk add --no-cache curl && \

	# Make sure that crontabs folder is set
	mkdir -p /var/spool/cron/crontabs && \

	# Install minio client
	curl -L -o /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
	chmod +x /usr/local/bin/mc

# Install flynn client
COPY scripts /scripts
ENTRYPOINT /scripts/backup.sh

# This env will tell the backup interval for crond
ENV BACKUP_INTERVAL="* * * * *"

# Because cron daemon can't read the minio client configs just use sleep instead
ENV BACKUP_INTERVAL_SECONDS="10800"