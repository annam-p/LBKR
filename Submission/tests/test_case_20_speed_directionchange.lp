% ===== TEST CASE =====

% Combined rules: left turn + priority + speed (violation)
% StVO § 11, StVO § 19 and StVO § 20
% Scenario: vehicle a turns left, takes priority from oncoming traffic, and enters a road too fast.
% Expected output: result(violation(combined_speed_priority_turn,v_a speeding)) 
%                  result(violation(combined_speed_priority_turn,v_a,maneuver_without_previous_signal))
%                  result(violation(combined_speed_priority_turn,v_a unsafe_to_perform_maneuver)) 

vehicle(v_a; v_b).
road(r_rural; r_town).
road_type(r_rural, rural).
road_type(r_town, intown).
driving(v_a, r_town).
driving(v_b, r_town).
speed(v_a, 70).
speed(v_b, 40).

performs_left_turn(v_a, r_town).
signalled_during(v_a, left_turn(r_town)).

approaching_intersection(v_a, i1).
approaching_intersection(v_b, i1).
approaches_from_right(v_a, v_b, i1).
proceeds(v_a, i1).

result(ok(combined_speed_priority_turn, passed)) :-
    not violation(_, _).

result(violation(combined_speed_priority_turn, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
