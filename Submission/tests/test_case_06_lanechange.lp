% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A lane change is performed safely with previous and continuous signalling.
% Expected output: result(ok(rule3_lane_change, passed))

vehicle(v1).
lane(l1).
lane(l2).
performs_lane_change(v1, l1, l2).
sufficient_visibility(v1).
signalled_before(v1, lane_change(l1, l2)).
signalled_during(v1, lane_change(l1, l2)).


result(ok(rule3_lane_change, passed)) :-
    not violation(_, _).

result(violation(rule3_lane_change, Reason)) :-
    violation(_, Reason).

#show result/1
.
