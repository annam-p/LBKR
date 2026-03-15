% ===== TEST CASE =====

% Combined rules: priority exception + overtaking
% StVO § 19 and StVO § 16
% Scenario: Emergency-vehicle priority exception applies; overtaking has no prohibited condition.
% Expected output: result(ok(combined_rule4_rule5, passed))

vehicle(a;b).
traffic_keeps(right).
approaching_intersection(a, i1).
approaching_intersection(b, i1).
approaches_from_right(a, b, i1).
emergency_vehicle(b).
proceeds(b, i1).

overtakes(a, b).


result(ok(combined_rule4_rule5, passed)) :-
    not violation(_, _).

result(violation(combined_rule4_rule5, Reason)) :-
    violation(_, Reason).

#show result/1.
