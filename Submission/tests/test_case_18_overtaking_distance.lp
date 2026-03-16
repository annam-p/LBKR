% ===== TEST CASE =====

% Combined rules: overtaking + following distance (violation)
% StVO § 16 and StVO § 18 Abs. 1
% Scenario: a overtakes b, but cannot re-enter safely because b is too close to its front vehicle c.
% Expected output: result(violation(combined_overtaking_distance, v_b, insufficient_following_distance)) 
%                  result(violation(combined_overtaking_distance, v_a, overtaking_unsafe_reentry))

vehicle(v_a; v_b; v_c).
speed(v_a, 120).
speed(v_b, 90).

overtakes(v_a, v_b).
sufficient_space_for_overtaking(v_a).
sufficient_visibility(v_a).
intersection_signal_controlled(v_a).

follows(v_b, v_c).
gap(v_b, v_c, 10).
speed(v_c, 80).


result(ok(combined_overtaking_distance, passed)) :-
    not violation(_, _).

result(violation(combined_overtaking_distance, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
