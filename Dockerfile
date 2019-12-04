FROM hariszaf/pema:v1


MAINTAINER S. Koulouzis

RUN apt-get update --fix-missing && apt-get -y upgrade && apt-get install -y git python3 python3-pip && pip3 install clam requests
RUN mkdir -p /mnt/analysis/mydata


WORKDIR /home
COPY pema /home/pema
WORKDIR /home/pema

EXPOSE 8080
# ENTRYPOINT python3 setup.py install && ./startserver_development.sh
# CMD python3 setup.py install && ./startserver_development.sh
