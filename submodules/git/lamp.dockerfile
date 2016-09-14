FROM mittax/lamp
COPY run_lamp.sh /run_lamp.sh

RUN chmod +x /run_lamp.sh
CMD ["/bin/bash", "-lc", "/run_lamp.sh"]


