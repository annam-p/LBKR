% ===== TEST CASE =====

% Following distance
% StVO § 18 Abs. 1
% Scenario: A vehicle keeps too little distance to the vehicle in front.
% Expected output: result(violation(rule2_following_distance, v_b, insufficient_following_distance))

vehicle(v_a;v_b).
follows(v_b, v_a).
gap(v_b, v_a, 10).


result(ok(rule2_following_distance, passed)) :-
    not violation(_, _).

result(violation(rule2_following_distance, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
