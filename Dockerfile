FROM hariszaf/pema:v1


MAINTAINER S. Koulouzis

RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get install -y git python3 python3-pip
RUN pip3 install clam requests

# RUN ln -s /home/PEMA_v1.bds /usr/local/bin/PEMA_v1.bds
# RUN chmod +x /home/PEMA_v1.bds

RUN mkdir -p /mnt/analysis/mydata


WORKDIR /home
COPY pema /home/pema
WORKDIR /home/pema

EXPOSE 8080
ENTRYPOINT python3 setup.py install && ./startserver_development.sh
# CMD python3 setup.py install && ./startserver_development.sh
