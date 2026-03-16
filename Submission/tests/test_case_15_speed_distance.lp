% ===== TEST CASE =====

% Combined rules: speed + following distance
% StVO § 20 and StVO § 18 Abs. 1
% Scenario: Vehicles driving on rural and have a valid distance but vehicle 2 is speeding.
% Expected output: result(violation(combined_speed_distance, v_b, speeding))

vehicle(v_a;v_b).
road(r1).
road_type(r1, rural).
driving(v_a, r1).
driving(v_b, r1).
speed(v_a, 90).
speed(v_b, 105).

follows(v_b, v_a).
gap(v_b, v_a, 35).


result(ok(combined_speed_distance, passed)) :-
    not violation(_, _).

result(violation(combined_speed_distance, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
