FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y bash coreutils findutils \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY archive_overleaf_pdfs.sh /app/archive_overleaf_pdfs.sh
RUN chmod +x /app/archive_overleaf_pdfs.sh

CMD ["bash", "-c", "while true; do ./archive_overleaf_pdfs.sh; sleep ${SCAN_INTERVAL_SECONDS:-120}; done"]