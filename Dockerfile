FROM google/cloud-sdk:alpine

RUN apk --update --no-cache add postgresql-client

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]