FROM debian:jessie
MAINTAINER mittax

RUN useradd -d "/var/lib/jenkins" -u 107 -m -s /bin/bash jenkins

COPY ./jenkins/ /var/lib/jenkins/
RUN chown -R jenkins:jenkins /var/lib/jenkins
RUN ls -lah /var/lib/jenkins

RUN mkdir -p /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

VOLUME ["/var/log/jenkins","/var/lib/jenkins"]

USER jenkins

CMD ["echo", "Data container for Jenkins"]