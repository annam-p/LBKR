% ===== TEST CASE =====

% Following distance
% StVO § 18 Abs. 1
% Scenario: A vehicle keeps too little distance to the vehicle in front.
% Expected output: result(violation(rule2_following_distance, insufficient_following_distance))

vehicle(v1;v2).
follows(v2, v1).
gap(v2, v1, 10).


result(ok(rule2_following_distance, passed)) :-
    not violation(_, _).

result(violation(rule2_following_distance, Reason)) :-
    violation(_, Reason).

#show result/1.
