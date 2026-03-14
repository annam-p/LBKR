% ===== TEST CASE =====

% Priority at intersections
% StVO § 19
% Scenario: Vehicle b yields correctly to vehicle a from the right.
% Expected output: result(ok(rule4_priority, passed))

vehicle(a;b).
traffic_keeps(right).
approaching_intersection(a, i1).
approaching_intersection(b, i1).
approaches_from_right(a, b, i1).


result(ok(rule4_priority, passed)) :-
    not violation(_, _).

result(violation(rule4_priority, Reason)) :-
    violation(_, Reason).

#show result/1.
