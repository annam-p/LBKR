% ===== TEST CASE =====

% Priority at intersections
% StVO § 19
% Scenario: Vehicle b yields correctly to vehicle a from the right.
% Expected output: result(ok(rule4_priority, passed))

vehicle(v_a; v_b).
intersections(i1).
approaching_intersection(v_a, i1).
approaching_intersection(v_b, i1).
approaches_from_right(v_a, v_b, i1).


result(ok(rule4_priority, passed)) :-
    not violation(_, _).

result(violation(rule4_priority, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
