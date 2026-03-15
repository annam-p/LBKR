% ===== TEST CASE =====

% Combined rules: lane change + priority + overtaking
% StVO § 11, StVO § 19, StVO § 16
% Scenario: There are violations in priority, lane-change signalling, and overtaking visibility.
% Expected output: result(violation(combined_rule3_rule4_rule5, ...))

vehicle(a;b;c).

traffic_keeps(right).
approaching_intersection(a, i1).
approaching_intersection(b, i1).
approaches_from_right(a, b, i1).
proceeds(b, i1).

performs_lane_change(c, l2).
lane(l2).
sufficient_visibility(c).
signalled_before(c, lane_change(l2)).

overtakes(a, b).
poor_visibility(a).


result(ok(combined_rule3_rule4_rule5, passed)) :-
    not violation(_, _).

result(violation(combined_rule3_rule4_rule5, Reason)) :-
    violation(_, Reason).

#show result/1.
