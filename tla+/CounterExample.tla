-------------------------- MODULE CounterExample --------------------------

EXTENDS EgalitarianPaxos, TLC

-----------------------------------------------------------------------------

CONSTANTS p1, p2, p3, c1, c2
VARIABLES HIndex

MCReplicas ==  {p1, p2, p3}
MCCommands == {c1, c2}
MCFastQuorums(X) == IF X=p1 THEN {{p1,p3}}
                    ELSE IF X=p2 THEN {{p1,p2}}
                    ELSE {{p2,p3}}
MCSlowQuorums(X) == MCFastQuorums(X)
MCMaxBallot == 5

AdvanceHistory(pos) == /\ HIndex = pos
                       /\ HIndex' = HIndex + 1

NewInit ==
  /\ HIndex = 1
  /\ sentMsg = {}
  /\ cmdLog = [r \in Replicas |-> {}]
  /\ proposed = {}
  /\ executed = [r \in Replicas |-> {}]
  /\ crtInst = [r \in Replicas |-> 1]
  /\ leaderOfInst = [r \in Replicas |-> {}]
  /\ committed = [i \in Instances |-> {}]
  /\ ballots = 1
  /\ preparing = [r \in Replicas |-> {}]

NewNext == \/ (AdvanceHistory(1) /\ Propose(c1,p3))
           \/ (AdvanceHistory(2) /\ Propose(c2,p1))
 	   \/ (AdvanceHistory(3) /\ Phase1Reply(p3))
    	   \/ (AdvanceHistory(4) /\ SendPrepare(p3,<<p1,1>>,{p2,p3}))
       	   \/ (AdvanceHistory(5) /\ ReplyPrepare(p2))
	   \/ (AdvanceHistory(6) /\ ReplyPrepare(p3))
       	   \/ (AdvanceHistory(7) /\ PrepareFinalize(p3,<<p1,1>>,{p2,p3}))
           \/ (AdvanceHistory(8) /\ SendPrepare(p2,<<p1,1>>,{p1,p2}))
	   \/ (AdvanceHistory(9) /\ ReplyPrepare(p1))
 	   \/ (AdvanceHistory(10) /\ ReplyPrepare(p2))
    	   \/ (AdvanceHistory(11) /\ PrepareFinalize(p2,<<p1,1>>,{p1,p2}))
       	   \/ (AdvanceHistory(12) /\ Phase1Reply(p1))
	   \/ (AdvanceHistory(13) /\ Phase1Slow(p2,<<p1,1>>,{p1,p2}))
           \/ (AdvanceHistory(14) /\ Phase2Reply(p1))
 	   \/ (AdvanceHistory(15) /\ SendPrepare(p1,<<p1,1>>,{p1,p3}))
    	   \/ (AdvanceHistory(16) /\ ReplyPrepare(p3))
 	   \/ (AdvanceHistory(17) /\ SendPrepare(p1,<<p1,1>>,{p1,p3}))
	   \/ (AdvanceHistory(18) /\ ReplyPrepare(p3))
  	   \/ (AdvanceHistory(19) /\ ReplyPrepare(p1)) 
     	   \/ (AdvanceHistory(20) /\ ReplyPrepare(p1)) (* answer both ballots *)
       	   \/ (AdvanceHistory(21) /\ PrepareFinalize(p1,<<p1,1>>,{p1,p3}))
	   \/ (AdvanceHistory(22) /\ Phase2Reply(p3))
	   \/ (AdvanceHistory(23) /\ Phase2Finalize(p2,<<p1,1>>,{p1,p2}))
  	   \/ (AdvanceHistory(24) /\ Phase2Finalize(p1,<<p1,1>>,{p1,p3}))		   

=============================================================================