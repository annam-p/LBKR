% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A driver want to do a right turn but the road is blocked. 
% Expected output: result(violation(rule3_direction_change, v_a, maneuver_without_continuous_signal)) 
%                  result(violation(rule3_direction_change, v_a, unsafe_to_perform_maneuver))

vehicle(v_a).
road(r1).
performs_right_turn(v_a, r1).
obstacle_on_road(r1).
signalled_before(v_a, right_turn(r1)).


result(ok(rule3_direction_change, passed)) :-
    not violation(_, _).

result(violation(rule3_direction_change, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
