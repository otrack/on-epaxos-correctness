FROM talex5/tla

ENV NAME=epaxos-counter-example

WORKDIR $NAME

RUN apt-get update
RUN apt-get install -y git maven
RUN git clone https://github.com/efficient/epaxos
RUN cp epaxos/tla+/EgalitarianPaxos.tla .
ADD tla+/CounterExample.cfg .
ADD tla+/CounterExample.tla .
ADD bin/run.sh .

CMD ["bash", "/epaxos-counter-example/run.sh"]
