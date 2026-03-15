% ===== TEST CASE =====

% Priority at intersections
% StVO § 19
% Scenario: Vehicle b comes from the right but has a stopsign and still proceeds.
% Expected output: result(violation(rule4_priority, failed_to_yield_at_intersection))

vehicle(v_a; v_b).
intersection(i1).
approaching_intersection(v_a, i1).
approaching_intersection(v_b, i1).
approaches_from_right(v_b, v_a, i1).
has_stop_sign(v_b, i1).
proceeds(v_b, i1).


result(ok(rule4_priority, passed)) :-
    not violation(_, _).

result(violation(rule4_priority, Reason)) :-
    violation(_, Reason).

#show result/1.
