FROM mittax/lamp
COPY run_lamp.sh /run_lamp.sh
COPY startSlave.sh /usr/local/jenkins
COPY slave.jar /usr/local/jenkins

RUN chmod +x /run_lamp.sh
CMD ["/bin/bash", "-lc", "/run_lamp.sh"]


