% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A lane change is performed safely with previous and continuous signalling.
% Expected output: result(ok(rule3_lane_change, passed))

vehicle(v_a).
lane(l1).
lane(l2).
performs_lane_change(v_a, l1, l2).
sufficient_visibility(v_a).
signalled_before(v_a, lane_change(l1, l2)).
signalled_during(v_a, lane_change(l1, l2)).


result(ok(rule3_lane_change, passed)) :-
    not violation(_, _).

result(violation(rule3_lane_change, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1
.
