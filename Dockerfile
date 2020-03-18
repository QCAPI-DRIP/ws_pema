FROM hariszaf/pema:latest


MAINTAINER S. Koulouzis

RUN apt-get update --fix-missing && apt-get -y upgrade && apt-get install -y git python3 python3-pip && pip3 install --upgrade pip && pip3 install clam requests
# RUN mkdir -p /mnt/analysis/mydata

WORKDIR /home
COPY pema /home/pema
WORKDIR /home/pema
ENV PATH="/home/tools/BDS/.bds:${PATH}"

EXPOSE 8080
# ENTRYPOINT python3 setup.py install && ./startserver_development.sh
CMD python3 setup.py install && /home/pema/startserver_development.sh
# CMD /home/PEMA_v1.bds
