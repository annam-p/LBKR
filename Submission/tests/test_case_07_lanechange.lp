% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A lane change is performed savely but the driver did not indicate it beforehand.
% Expected output: result(violation(rule3_lane_change, maneuver_without_previous_signal))

vehicle(v1).
lane(l1).
lane(l2).
performs_lane_change(v1, l1, l2).
sufficient_visibility(v1).
signalled_during(v1, lane_change(l1, l2)).

result(ok(rule3_lane_change, passed)) :-
    not violation(_, _).

result(violation(rule3_lane_change, Reason)) :-
    violation(_, Reason).

#show result/1.
