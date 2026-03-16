% ===== TEST CASE =====

% Speed limits and abnormally slow driving
% StVO § 20
% Scenario: A vehicle exceeds the applicable speed limit (driving 55 in a 50 zone).
% Expected output: result(violation(rule1_speed, v_a, speeding))

vehicle(v_a).
road(r1).
road_type(r1, intown).
driving(v_a, r1).
speed(v_a, 55).


result(ok(rule1_speed, passed)) :-
    not violation(_, _).

result(violation(rule1_speed, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
