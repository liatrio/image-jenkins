FROM jenkins/jenkins:2.348

LABEL org.opencontainers.image.source https://github.com/liatrio/builder-images

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt | tr '\n' ' ')

ENV PIPELINE_PLUGIN_VERSION 1.0.3
RUN curl -Lo /usr/share/jenkins/ref/plugins/pipeline-status-plugin.jpi \
     https://github.com/liatrio/pipeline-status-plugin/releases/download/v${PIPELINE_PLUGIN_VERSION}/pipeline-status-plugin.jpi
