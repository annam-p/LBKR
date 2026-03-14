% ===== TEST CASE =====

% Speed limits and abnormally slow driving
% StVO § 20
% Scenario: A vehicle drives within the applicable speed limit on a rural road and is not abnormally slow.
% Expected output: result(ok(rule1_speed, passed))

vehicle(v1).
road(r1).
road_type(r1, rural).
driving(v1, r1).
speed(v1, 90).


result(ok(rule1_speed, passed)) :-
    not violation(_, _).

result(violation(rule1_speed, Reason)) :-
    violation(_, Reason).

#show result/1.
