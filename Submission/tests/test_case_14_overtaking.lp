% ===== TEST CASE =====

% Prohibited overtaking
% StVO § 16
% Scenario: Overtaking is allowed but all other premisis are not met.
% Expected output: result(violation(rule5_overtaking, v_a, overtaking_insufficient_space)) 
%                  result(violation(rule5_overtaking, v_a, overtaking_speed_difference_too_small)) 
%                  result(violation(rule5_overtaking, v_a, overtaking_unsafe_reentry)) 
%                  result(violation(rule5_overtaking, v_a, overtaking_insufficient_visibility))

vehicle(v_a; v_b).
overtakes(v_a, v_b).


result(ok(rule5_overtaking, passed)) :-
    not violation(_, _).

result(violation(rule5_overtaking, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
