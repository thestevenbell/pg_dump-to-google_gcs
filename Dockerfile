FROM google/cloud-sdk:alpine

RUN apk --update --no-cache add postgresql-client
RUN apk --no-cache add jq

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]