% ===== TEST CASE =====

% Combined rules: following distance + overtaking (violation)
% StVO § 18 Abs. 1 and StVO § 16
% Scenario: follower keeps insufficient distance and another vehicle overtakes with insufficient space.
% Expected output: result(violation(combined_overtaking_distanve,v_b,insufficient_following_distance)) 
%                  result(violation(combined_overtaking_distanve,v_c,overtaking_insufficient_space))

vehicle(v_a; v_b; v_c; v_d).

follows(v_b, v_a).
gap(v_b, v_a, 10).

overtakes(v_c, v_d).
sufficient_visibility(v_c).
safe_reentry_after_overtake(v_c).
speed(v_c, 125).
speed(v_d, 90).

result(ok(combined_overtaking_distanve, passed)) :-
    not violation(_, _).

result(violation(combined_overtaking_distanve, Vehicle, Reason)) :-
    violation(Vehicle, Reason).

#show result/1.
