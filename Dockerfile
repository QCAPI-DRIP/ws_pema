FROM hariszaf/pema:v1


MAINTAINER S. Koulouzis

RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get install -y git python3 python3-pip virtualenv





WORKDIR /root
RUN virtualenv --python=python3 clamenv 
EXPOSE 8080

ENTRYPOINT source clamenv/bin/activate && pip3 install clam && python3 setup.py install && ./startserver_development.sh
