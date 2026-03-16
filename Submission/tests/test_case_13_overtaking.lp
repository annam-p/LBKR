% ===== TEST CASE =====

% Prohibited overtaking
% StVO § 16
% Scenario: A vehicle overtakes although there is a no_overtaking sign.
% Expected output: result(violation(rule5_overtaking, v_a, overtaking_poor_visibility))

vehicle(v_a;v_b).
road(r1).
overtakes(v_a, v_b).
speed(v_a, 80).
speed(v_b, 50).
no_overtaking_sign(r1).
sufficient_space_for_overtaking(v_a).
safe_reentry_after_overtake(v_a).
sufficient_visibility(v_a).



result(ok(rule5_overtaking, passed)) :-
    not violation(_, _).

result(violation(rule5_overtaking, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
