FROM alpine:3.10.1
RUN apk --update --no-cache add postgresql-client
RUN apk --no-cache add tar
RUN apk --no-cache add tree

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]