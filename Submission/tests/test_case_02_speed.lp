% ===== TEST CASE =====

% Speed limits and abnormally slow driving
% StVO § 20
% Scenario: A vehicle exceeds the applicable speed limit.
% Expected output: result(violation(rule1_speed, speeding))

vehicle(v1).
road(r1).
road_type(r1, intown).
driving(v1, r1).
speed(v1, 55).


result(ok(rule1_speed, passed)) :-
    not violation(_, _).

result(violation(rule1_speed, Reason)) :-
    violation(_, Reason).

#show result/1.
