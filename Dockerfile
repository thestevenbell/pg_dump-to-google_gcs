FROM alpine:3.10.1
RUN apk --update --no-cache add postgresql-client

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [". /run.sh"]