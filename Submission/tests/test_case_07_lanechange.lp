% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A lane change is performed savely but the driver did not indicate it beforehand.
% Expected output: result(violation(rule3_lane_change, v_a, maneuver_without_previous_signal))

vehicle(v_a).
lane(l1).
lane(l2).
performs_lane_change(v_a, l1, l2).
sufficient_visibility(v_a).
signalled_during(v_a, lane_change(l1, l2)).

result(ok(rule3_lane_change, passed)) :-
    not violation(_, _).

result(violation(rule3_lane_change, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
