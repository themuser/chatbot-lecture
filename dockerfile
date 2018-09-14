from ubuntu:16.04

RUN mkdir /chatbot
COPY ./ /chatbot/
RUN echo "Hello, world!"
RUN ls -al /chatbot
