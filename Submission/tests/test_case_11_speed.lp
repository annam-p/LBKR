% ===== TEST CASE =====

% Combined rules: speed + following distance
% StVO § 20 and StVO § 18 Abs. 1
% Scenario: Vehicles comply with both speed and following-distance rules.
% Expected output: result(ok(combined_rule1_rule2, passed))

vehicle(v1;v2).
road(r1).
road_type(r1, rural).
driving(v1, r1).
speed(v1, 90).

follows(v2, v1).
gap(v2, v1, 25).


result(ok(combined_rule1_rule2, passed)) :-
    not violation(_, _).

result(violation(combined_rule1_rule2, Reason)) :-
    violation(_, Reason).

#show result/1.
