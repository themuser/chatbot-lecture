from ubuntu:16.04

RUN mkdir /chatbot
COPY ./ /chatbot/
RUN ls -al /chatbot
