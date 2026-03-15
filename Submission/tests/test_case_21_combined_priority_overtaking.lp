% ===== TEST CASE =====

% Combined rules: priority + overtaking
% StVO § 19 and StVO § 16
% Scenario: Vehicle fails to yield and overtakes in poor visibility.
% Expected output: result(violation(combined_rule4_rule5, ...))

vehicle(a;b).
traffic_keeps(right).
approaching_intersection(a, i1).
approaching_intersection(b, i1).
approaches_from_right(a, b, i1).
proceeds(b, i1).

overtakes(a, b).
poor_visibility(a).


result(ok(combined_rule4_rule5, passed)) :-
    not violation(_, _).

result(violation(combined_rule4_rule5, Reason)) :-
    violation(_, Reason).

#show result/1.
