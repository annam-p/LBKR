% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A lane change is performed without signalling before the action.
% Expected output: result(violation(rule3_lane_change, lane_change_without_continuous_signal))

vehicle(v1).
lane(l2).
performs_lane_change(v1, l1).
signalled_during(v1, lane_change).

result(ok(rule3_lane_change, passed)) :-
    not violation(_, _).

result(violation(rule3_lane_change, Reason)) :-
    violation(_, Reason).

#show result/1.
