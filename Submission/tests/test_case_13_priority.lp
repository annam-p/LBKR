% ===== TEST CASE =====

% Combined rules: lane change + priority + overtaking
% StVO § 11, StVO § 19, StVO § 16
% Scenario: Lane change, priority behavior, and overtaking are all compliant.
% Expected output: result(ok(combined_rule3_rule4_rule5, passed))

vehicle(a;b;c).

performs_lane_change(c).
lane(l2).
intends_lane_change(c, l2).
sufficient_visibility(c).
signalled_before(c, lane_change).
signalled_during(c, lane_change).

traffic_keeps(right).
approaching_intersection(a, i1).
approaching_intersection(b, i1).
approaches_from_right(a, b, i1).

overtakes(a, b).


result(ok(combined_rule3_rule4_rule5, passed)) :-
    not violation(_, _).

result(violation(combined_rule3_rule4_rule5, Reason)) :-
    violation(_, Reason).

#show result/1.
