FROM alpine:3.4

RUN set -x && \

	# Install curl for flynn http api
	apk add --no-cache curl && \

	# Install minio client for transfering files into s3
	curl -L -o /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
	chmod +x /usr/local/bin/mc

# Add backup script
COPY scripts /scripts
COPY backup /backup
#ENTRYPOINT /scripts/backup.sh

# This is the time that the bash script waits before backup
ENV BACKUP_INTERVAL_SECONDS="5"
ENV AWS_ACCESS_KEY_ID="AKIAIDNXWO2O5QWHU7QA"
ENV AWS_S3_BUCKET="flynn-hki-stage"
ENV AWS_SECRET_ACCESS_KEY="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"
ENV FLYNN_AUTH_KEY="bcf447740797c6de180aa353844f6249"