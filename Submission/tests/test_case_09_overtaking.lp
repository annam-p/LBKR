% ===== TEST CASE =====

% Prohibited overtaking
% StVO § 16
% Scenario: Overtaking takes place without any prohibited overtaking condition.
% Expected output: result(ok(rule5_overtaking, passed))

vehicle(v1).
overtakes(v1, v2).


result(ok(rule5_overtaking, passed)) :-
    not violation(_, _).

result(violation(rule5_overtaking, Reason)) :-
    violation(_, Reason).

#show result/1.
