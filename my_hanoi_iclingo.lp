#const n = 6.
#const p = 3.
peg(1..p).
disk(1..n).
init_on(D,1) :- disk(D).
goal_on(p).

moves(0).
#cumulative m2.

moves(m2).
1 { move(D,P,m2) : disk(D) : peg(P) } 1.
1 { on(D,P,m2) : disk(D) : peg(P) } 1 :- D = 1..n.

nomove(D,P,T) :- disk(D), peg(P), moves(T), 1 { on(D2,P,T): disk(D2) : D2 >= D}.
blocked(D,P,T) :- on(D,P,T), 1 { on(D2,P,T): disk(D2) : D2 > D }.
blocked(D,T) :- blocked(D,_,T).
move(D,T) :- move(D,_,T).
:- move(D,P,T), nomove(D,P,T-1).
:- move(D,T), blocked(D,T-1).

on(D,P,0) :- init_on(D,P).
on(D,P,T) :- move(D,P,T).
on(D,P,T) :- moves(T),on(D,P,T-1), not move(D,T).

#volatile m2.
finalstatus(m2) :- moves(m2), goal_on(P), n {on(D,P,m2) : disk(D)} n.
:- #count {finalstatus(T):moves(T)} 0.

#hide.
#show move/3.
