% ===== TEST CASE =====

% Prohibited overtaking
% StVO § 16
% Scenario: A vehicle overtakes in poor visibility.
% Expected output: result(violation(rule5_overtaking, overtaking_poor_visibility))

vehicle(v1).
road(r1).
overtakes(v1, v2).
no_overtaking_sign(r1).



result(ok(rule5_overtaking, passed)) :-
    not violation(_, _).

result(violation(rule5_overtaking, Reason)) :-
    violation(_, Reason).

#show result/1.
