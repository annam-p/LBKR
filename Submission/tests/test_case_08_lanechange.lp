% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A driver want to change to a lane but another vehicle is approaching
% Expected output: result(violation(rule3_lane_change, unsafe_to_perform_maneuver))

vehicle(v1,v2).
lane(l1).
lane(l2).
performs_lane_change(v1, l1, l2).
sufficient_visibility(v1).
approaching_vehicle(v2, l2).
signalled_before(v1, lane_change(l1, l2)).
signalled_during(v1, lane_change(l1, l2)).


result(ok(rule3_lane_change, passed)) :-
    not violation(_, _).

result(violation(rule3_lane_change, Reason)) :-
    violation(_, Reason).

#show result/1.
