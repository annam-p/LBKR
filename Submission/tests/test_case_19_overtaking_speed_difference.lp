% ===== TEST CASE =====

% Prohibited overtaking
% StVO § 16
% Scenario: A vehicle overtakes with less than 20 km/h speed difference.
% Expected output: result(violation(rule5_overtaking, overtaking_speed_difference_too_small))

vehicle(v1;v2).
overtakes(v1, v2).
speed(v1, 90).
speed(v2, 75).


result(ok(rule5_overtaking, passed)) :-
    not violation(_, _).

result(violation(rule5_overtaking, Reason)) :-
    violation(_, Reason).

#show result/1.
