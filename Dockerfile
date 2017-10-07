# Use Alpine Linux as base image
FROM alpine:latest

ADD ./bin/txtchat /bin

CMD ["txtchat"]