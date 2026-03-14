% ===== TEST CASE =====

% Combined rules: speed + following distance
% StVO § 20 and StVO § 18 Abs. 1
% Scenario: One vehicle speeds and the follower has insufficient distance.
% Expected output: result(violation(combined_rule1_rule2, ...))

vehicle(v1;v2).
road(r1).
road_type(r1, rural).
driving(v1, r1).
speed(v1, 120).

follows(v2, v1).
gap(v2, v1, 10).


result(ok(combined_rule1_rule2, passed)) :-
    not violation(_, _).

result(violation(combined_rule1_rule2, Reason)) :-
    violation(_, Reason).

#show result/1.
