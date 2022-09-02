FROM jenkins/jenkins:2.346.3-2-lts-alpine

LABEL org.opencontainers.image.source https://github.com/liatrio/builder-images

USER root
RUN apk add curl=7.85.0-r0 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main && apk add libcurl=7.85.0-r0 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
ENV CURL_OPTIONS -sSfL --http1.1
ENV CURL_CONNECTION_TIMEOUT 60
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

ENV PIPELINE_PLUGIN_VERSION 1.0.3
RUN curl -Lo /usr/share/jenkins/ref/plugins/pipeline-status-plugin.jpi \
	https://github.com/liatrio/pipeline-status-plugin/releases/download/${PIPELINE_PLUGIN_VERSION}/pipeline-status-plugin.jpi
USER 1000
