% ===== TEST CASE =====

% Combined rules: speed + lane change
% StVO § 20 and StVO § 11
% Scenario: Vehicle speeds and changes lane without continuous signalling.
% Expected output: result(violation(combined_rule1_rule3, ...))

vehicle(v1).
road(r1).
road_type(r1, rural).
driving(v1, r1).
speed(v1, 120).

performs_lane_change(v1, l2).
lane(l2).
sufficient_visibility(v1).
signalled_before(v1, lane_change(l2)).


result(ok(combined_rule1_rule3, passed)) :-
    not violation(_, _).

result(violation(combined_rule1_rule3, Reason)) :-
    violation(_, Reason).

#show result/1.
