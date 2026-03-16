% ===== TEST CASE =====

% Speed limits and abnormally slow driving
% StVO § 20
% Scenario: A vehicle is diving abnormally slow on the highway without cause
% Expected output: result(violation(rule1_speed, v_a, abnormally slow_without_cause))

vehicle(v_a).
road(r1).
road_type(r1, highway).
driving(v_a, r1).
speed(v_a, 65).


result(ok(rule1_speed, passed)) :-
    not violation(_, _).

result(violation(rule1_speed, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
