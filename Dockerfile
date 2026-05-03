FROM ubuntu:24.04

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

ENV DEVOPS="Andrii Maryniak"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
