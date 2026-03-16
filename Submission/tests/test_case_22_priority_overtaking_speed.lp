% ===== TEST CASE =====

% Combined rules: priority + overtaking (violation)
% StVO § 19 and StVO § 16
% Scenario: overtaking at intersection with violating speed limits and taking priority.
% Expected output: result(violation(combined_priority_overtaking_speed,v_a,speeding)) 
%                  result(violation(combined_priority_overtaking_speed,v_b,speeding)) 
%                  result(violation(combined_priority_overtaking_speed,v_a,failed_to_yield_at_intersection)) 
%                  result(violation(combined_priority_overtaking_speed,v_b,failed_to_yield_at_intersection)) 
%                  result(violation(combined_priority_overtaking_speed,v_a,overtaking_before_uncontrolled_intersection)) 
%                  result(violation(combined_priority_overtaking_speed,v_a,overtaking_speed_difference_too_small))

vehicle(v_a; v_b; v_c).
road(r1).
road_type(r1, rural).
driving(v_a, r1).
driving(v_b, r1).
speed(v_a, 115).
speed(v_b, 105).
approaching_intersection(v_a, i1).
approaching_intersection(v_b, i1).
approaching_intersection(v_c, i1).
approaches_from_right(v_c, v_a, i1).
proceeds(v_a, i1).
approaches_from_right(v_c, v_b, i1).
proceeds(v_b, i1).


overtakes(v_a, v_b).
intersection_signal_controlled(v_a).
sufficient_space_for_overtaking(v_a).
safe_reentry_after_overtake(v_a).
sufficient_visibility(v_a).

result(ok(combined_priority_overtaking_speed, passed)) :-
    not violation(_, _).

result(violation(combined_priority_overtaking_speed, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
