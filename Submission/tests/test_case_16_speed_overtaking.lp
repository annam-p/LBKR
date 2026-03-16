% ===== TEST CASE =====

% Prohibited overtaking
% StVO § 16
% Scenario: A vehicle overtakes with less than 20 km/h speed difference.
% Expected output: result(violation(combined_speed_overtaking, v_a, overtaking_speed_difference_too_small))

vehicle(v_a;v_b).
road(r1).
road_type(r1, intown).
overtakes(v_a, v_b).
speed(v_a, 50).
speed(v_b, 35).
sufficient_space_for_overtaking(v_a).
safe_reentry_after_overtake(v_a).
sufficient_visibility(v_a).




result(ok(combined_speed_overtaking, passed)) :-
    not violation(_, _).

result(violation(combined_speed_overtaking, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
