% ===== TEST CASE =====

% Combined rules: lane change + priority + overtaking (violation)
% StVO § 11, StVO § 19, StVO § 16
% Scenario: overtaking at intersection
% Expected output: result(violation(combined_intersection_overtaking, v_b, overtaking_before_uncontrolled_intersection))

vehicle(v_a; v_b; v_c).
speed(v_b, 75).
speed(v_c, 50).

approaching_intersection(v_a, i1).
approaching_intersection(v_b, i1).
approaching_intersection(v_c, i1).
approaches_from_right(v_a, v_b, i1).
approaches_from_right(v_a, v_c, i1).


overtakes(v_b, v_c).
sufficient_space_for_overtaking(v_b).
safe_reentry_after_overtake(v_b).
sufficient_visibility(v_b).


result(ok(combined_intersection_overtaking, passed)) :-
    not violation(_, _).

result(violation(combined_intersection_overtaking, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
