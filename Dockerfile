FROM aquasec/trivy:0.27.1 AS trivy-img

FROM ghcr.io/safestack-hq/labval:v0.0.3 AS labs-validator
RUN apk update && apk add --update bash

COPY entrypoint.sh /entrypoint.sh
COPY --from=trivy-img /usr/local/bin/trivy /bin/trivy

ENTRYPOINT ["/entrypoint.sh"]
