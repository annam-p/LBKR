% ===== TRAFFIC RULES =====

% Speed limits and abnormally slow driving
% StVO § 20, VCoRT Art. 13(2,4)
% Intersectiont is illegal to drive faster than the speedlimits. Further each driver should not drive abnormally slow without reason 

speed_limit(intown, 50).
speed_limit(rural, 100).
speed_limit(highway, 130).

actual_speed_limit(Vehicle, Limit) :-
  driving(Vehicle, Road),
  road_type(Road, Type),
  speed_limit(Type, Limit),
  not legislativ_speed_limit(Vehicle, _).

actual_speed_limit(Vehicle, Limit) :-
  legislativ_speed_limit(Vehicle, Limit).

violation(Vehicle, speeding) :-
  speed(Vehicle, Speed),
  actual_speed_limit(Vehicle, Limit),
  Speed > Limit.

% picked a fixed number for abnormally slow: 2/3 from the speed limit
abnormally_slow(Vehicle) :-
  speed(Vehicle, Speed),
  actual_speed_limit(Vehicle, Limit),
  3 * Speed < 2 * Limit.

violation(Vehicle, abnormally_slow_without_cause) :-
  abnormally_slow(Vehicle),
  not proper_cause_slow(Vehicle).

% Following distance
% StVO §18(1), VCoRT Art. 13(5)
% The drive must always keep an apropriate gap between his car and the car in front so he can stop savely. 

violation(Follower, insufficient_following_distance) :-
  follows(Follower, Leader),
  gap(Follower, Leader, Gap),
  Gap < 20.

% Lane change safety and signalling 
% StVO §11, VCoRT Art. 14(1,3)
% A diver must not change lanes or directions if he would endanger others 
% and before and while changing he must signal what he is doing.
violation(Vehicle, maneuver_without_previous_signal) :-
  performs_maneuver(Vehicle, Maneuver),
  not signalled_before(Vehicle, Maneuver).

violation(Vehicle, maneuver_without_continuous_signal) :-
  performs_maneuver(Vehicle, Maneuver),
  not signalled_during(Vehicle, Maneuver).

violation(Vehicle, unsafe_to_perform_maneuver) :-
  performs_lane_change(Vehicle, TargetLane),
  not safe_to_change_lane(Vehicle, TargetLane).

violation(Vehicle, unsafe_to_perform_maneuver) :-
  performs_turn(Vehicle),
  not safe_to_perform_turn(Vehicle).


performs_maneuver(Vehicle, lane_change(TargetLane)) :-
  performs_lane_change(Vehicle, TargetLane).

performs_maneuver(Vehicle, left_turn) :-
  performs_left_turn(Vehicle).

performs_maneuver(Vehicle, right_turn) :-
  performs_right_turn(Vehicle).

performs_maneuver(Vehicle, turn_around) :-
  performs_turn_around(Vehicle).

performs_turn(Vehicle) :-
  performs_left_turn(Vehicle);
  performs_right_turn(Vehicle);
  performs_turn_around(Vehicle).


safe_to_change_lane(Vehicle, TargetLane) :-
  lane(TargetLane),
  sufficient_visibility(Vehicle),
  not lane_blocked(TargetLane).

lane_blocked(TargetLane) :-
  lane(TargetLane),
  obstacle_in_lane(TargetLane).

lane_blocked(TargetLane) :-
  lane(TargetLane),
  approaching_vehicle(Vehicle2, TargetLane).

safe_to_perform_turn(Vehicle) :-
  performs_turn(Vehicle),
  not turn_into_blocked_road(Vehicle),
  not violates_intersection_priority(Vehicle, _).

turn_into_blocked_road(Vehicle) :-
  turning_into(Vehicle, Road),
  vehicle_on_road(_, Road).

turn_into_blocked_road(Vehicle) :-
  turning_into(Vehicle, Road),
  obstacle_on_road(Road).

violates_intersection_priority(Vehicle1, Intersection) :-
  proceeds(Vehicle1, Intersection),
  approaching_intersection(Vehicle1, Intersection),
  approaching_intersection(Vehicle2, Intersection),
  Vehicle1 != Vehicle2,
  not has_priority(Vehicle1, Vehicle2, Intersection).

% Priority at intersections 
% StVO §19, VCoRT Art. 18(4)
% By default the vehicle comming from the right has priority. But under different circumstances (e.g. Roadsigns) this might change. 
has_priority(A, B, Intersection) :-
  approaching_intersection(A, Intersection),
  approaching_intersection(B, Intersection),
  approaches_from_right(A, B, Intersection),
  not exception_priority(B, A, Intersection).

give_way(B, A, Intersection) :- has_priority(A, B, Intersection).

% Priority exceptions
exception_priority(B, A, Intersection) :-
  emergency_vehicle(B),
  approaching_intersection(B, Intersection),
  approaching_intersection(A, Intersection).

exception_priority(B, A, Intersection) :-
  rail_vehicle(B),
  approaching_intersection(B, Intersection),
  approaching_intersection(A, Intersection).

exception_priority(B, A, Intersection) :-
  on_priority_road(B, Intersection),
  approaching_intersection(A, Intersection).

exception_priority(B, A, Intersection) :-
  has_stop_sign(A, Intersection),
  approaching_intersection(B, Intersection).

exception_priority(B, A, Intersection) :-
  has_yield_sign(A, Intersection),
  approaching_intersection(B, Intersection).

exception_priority(B, A, Intersection) :-
  entering_from_side_lane(B, Intersection),
  flowing_traffic(A, Intersection).

exception_priority(B, A, Intersection) :-
  leaving_cycle_path(B, Intersection),
  flowing_traffic(A, Intersection).

violation(Vehicle, failed_to_yield_at_intersection) :-
  proceeds(Vehicle, Intersection),
  give_way(Vehicle, _, Intersection).

% Prohibited overtaking 
% StVO §16
% A driver must only overtake if it is save and if he can ensure to not violate speeding limits, still needing as little time as possible
% no overtaking signs

violation(Vehicle, overtaking_no_overtaking_sign) :-
  overtakes(Vehicle, _),
  overtaking_sign(Road).

% overtaking at protected crossings or intersections
violation(Vehicle, overtaking_on_crossing) :-
  overtakes(Vehicle, _),
  on_crossing(Vehicle),
  not crossing_signal_controlled(Vehicle).

violation(Vehicle, overtaking_before_crossing) :-
  overtakes(Vehicle, _),
  before_crossing(Vehicle),
  not crossing_signal_controlled(Vehicle).

violation(Vehicle, overtaking_at_uncontrolled_intersection) :-
  overtakes(Vehicle, _),
  at_uncontrolled_intersection(Vehicle).

violation(Vehicle, overtaking_endangers_others) :-
  overtakes(Vehicle, O),
  may_endanger(Vehicle, O).

violation(Vehicle, overtaking_insufficient_space) :-
  overtakes(Vehicle, O),
  insufficient_space_to_overtake(Vehicle, O).

violation(Vehicle1, overtaking_speed_difference_too_small) :-
  overtakes(Vehicle1, Vehicle2),
  speed_difference_too_small(Vehicle1, Vehicle2).

speed_difference_too_small(Follower, Leader) :-
  speed(Follower, SpeedFollower),
  speed(Leader, SpeedLeader),
  (SpeedFollower - SpeedLeader) < 20.

violation(Vehicle, overtaking_unsafe_reentry) :-
  overtakes(Vehicle, O),
  unsafe_reentry_after_overtake(Vehicle, O).

violation(Vehicle, overtaking_poor_visibility) :-
  overtakes(Vehicle, _),
  poor_visibility(Vehicle).

violation(Vehicle, overtaking_blind_bend_or_crest) :-
  overtakes(Vehicle, _),
  blind_bend_or_crest(Vehicle).
