# On the correctness of Egalitarian Paxos

## Highlights

- There is a problem in the TLA+ specification and the Golang implementation of [Egalitarian Paxos](https://github.com/efficient/epaxos).
- A counter-example in TLA+ is provided (under `tla+/CounterExample.cfg`).
- The counter-example can be executed with the following command: `docker run --rm -ti 0track/epaxos-counter-example:latest`.
- The algorithm reaches a state in which processes disagree on the dependencies of a command; this breaks safety.

## FAQ

- _How was the bug discovered?_  
When auditing the recovery mechanism of EPaxos.

- _Is there a fix?_  
Each process needs to maintain the last ballot at which it voted.
This requires an additional ballot variable in the algorithm.
Such an approach is implemented in the [following](https://github.com/otrack/epaxos) repository.
The correctness of the resulting algorithm has not been established yet.
