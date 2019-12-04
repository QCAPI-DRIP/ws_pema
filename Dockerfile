FROM hariszaf/pema


MAINTAINER S. Koulouzis

RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get install -y git python3 python3-pip virtualenv
RUN pip3 install clam requests

RUN ln -s /home/PEMA_v1.bds /usr/local/bin/PEMA_v1.bds
RUN chmod +x /home/PEMA_v1.bds

RUN mkdir -p /mnt/analysis/mydata


WORKDIR /home
COPY pema /home/pema
WORKDIR /home/pema
# RUN virtualenv --python=python3 clamenv 

EXPOSE 8080
# ENTRYPOINT pip3 install clam && python3 setup.py install && ./startserver_development.sh
