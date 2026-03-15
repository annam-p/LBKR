% ===== TEST CASE =====

% Lane change safety and signalling
% StVO § 11
% Scenario: A driver want to do a right turn but the road is blocked. 
% Expected output: result(violation(rule3_direction_change,maneuver_without_continuous_signal)) 
%                  result(violation(rule3_direction_change,unsafe_to_perform_maneuver))

vehicle(v1).
road(r1).
performs_right_turn(v1, r1).
obstacle_on_road(r1).
signalled_before(v1, right_turn(r1)).


result(ok(rule3_direction_change, passed)) :-
    not violation(_, _).

result(violation(rule3_direction_change, Reason)) :-
    violation(_, Reason).

#show result/1.
