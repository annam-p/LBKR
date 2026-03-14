% ===== TEST CASE =====

% Speed limits and abnormally slow driving
% StVO § 20
% Scenario: A vehicle is diving abnormally slow on the highway without cause
% Expected output: result(violation(rule1_speed, abnormally slow_without_cause))

vehicle(v1).
road(r1).
road_type(r1, highway).
driving(v1, r1).
speed(v1, 65).


result(ok(rule1_speed, passed)) :-
    not violation(_, _).

result(violation(rule1_speed, Reason)) :-
    violation(_, Reason).

#show result/1.
