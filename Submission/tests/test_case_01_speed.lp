% ===== TEST CASE =====

% Speed limits and abnormally slow driving
% StVO § 20
% Scenario: A vehicle drives within the applicable speed limit on a rural road and is not abnormally slow.
% Expected output: result(ok(rule1_speed, passed))

vehicle(v_a).
road(r1).
road_type(r1, rural).
driving(v_a, r1).
speed(v_a, 90).


result(ok(rule1_speed, passed)) :-
    not violation(_, _).

result(violation(rule1_speed, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
