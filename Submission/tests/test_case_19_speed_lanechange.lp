% ===== TEST CASE =====

% Combined rules: speed + lane change (violation)
% StVO § 20 and StVO § 11
% Scenario: vehicle is speeding and lane change is invalid (same current and target lane) and not continuously signalled.
% Expected output: result(violation(combined_speed_lanechange, v_a, speeding)) 
%                  result(violation(combined_speed_lanechange, v_a, maneuver_without_continuous_signal)) 
%                  result(violation(combined_speed_lanechange, v_a, unsafe_to_perform_maneuver))

vehicle(v_a).
road(r1).
road_type(r1, rural).
driving(v_a, r1).
speed(v_a, 120).

lane(l1).
performs_lane_change(v_a, l1, l1).
sufficient_visibility(v_a).
signalled_before(v_a, lane_change(l1, l1)).

result(ok(combined_speed_lanechange, passed)) :-
    not violation(_, _).

result(violation(combined_speed_lanechange, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
