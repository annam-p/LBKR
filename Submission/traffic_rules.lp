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

performs_maneuver(Vehicle, lane_change(CurrentLane, TargetLane)) :-
  performs_lane_change(Vehicle, CurrentLane, TargetLane).

performs_maneuver(Vehicle, left_turn(Road)) :-
  performs_left_turn(Vehicle, Road).

performs_maneuver(Vehicle, right_turn(Road)) :-
  performs_right_turn(Vehicle, Road).

performs_maneuver(Vehicle, turn_around(Road)) :-
  performs_turn_around(Vehicle, Road).


violation(Vehicle, unsafe_to_perform_maneuver) :-
  performs_lane_change(Vehicle, CurrentLane, TargetLane),
  not safe_to_change_lane(Vehicle, CurrentLane, TargetLane).

violation(Vehicle, unsafe_to_perform_maneuver) :-
  performs_left_turn(Vehicle, Road),
  not safe_to_perform_turn(Vehicle, Road).

violation(Vehicle, unsafe_to_perform_maneuver) :-
  performs_right_turn(Vehicle, Road),
  not safe_to_perform_turn(Vehicle, Road).

violation(Vehicle, unsafe_to_perform_maneuver) :-
  performs_turn_around(Vehicle, Road),
  not safe_to_perform_turn(Vehicle, Road).


safe_to_change_lane(Vehicle, CurrentLane, TargetLane) :-
  valid_lane_change(CurrentLane, TargetLane),
  sufficient_visibility(Vehicle),
  not lane_blocked(TargetLane).

valid_lane_change(CurrentLane, TargetLane) :-
  lane(CurrentLane),
  lane(TargetLane),
  CurrentLane != TargetLane.

lane_blocked(TargetLane) :-
  lane(TargetLane),
  obstacle_in_lane(TargetLane).

lane_blocked(TargetLane) :-
  lane(TargetLane),
  approaching_vehicle(Vehicle2, TargetLane).

safe_to_perform_turn(Vehicle, Road) :-
  performs_turn(Vehicle, Road),
  road(Road),
  not turn_into_blocked_road(Vehicle, Road),
  not violates_intersection_priority(Vehicle, _).

turn_into_blocked_road(Vehicle, Road) :-
  performs_turn(Vehicle, Road),
  vehicle_on_road(_, Road).

turn_into_blocked_road(Vehicle, Road) :-
  performs_turn(Vehicle, Road),
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
has_priority(Vehicle1, Vehicle2, Intersection) :-
  approaching_intersection(Vehicle1, Intersection),
  approaching_intersection(Vehicle2, Intersection),
  approaches_from_right(Vehicle1, Vehicle2, Intersection),
  not exception_priority(Vehicle2, Vehicle1, Intersection).

% give_way(Vehicle2, Vehicle1, Intersection) :- has_priority(Vehicle1, Vehicle2, Intersection).

violation(Vehicle, failed_to_yield_at_intersection) :-
  proceeds(Vehicle, Intersection),
  not has_priority(_, Vehicle, Intersection).

% Priority exceptions
exception_priority(Vehicle2, Vehicle1, Intersection) :-
  emergency_vehicle(Vehicle2),
  approaching_intersection(Vehicle2, Intersection),
  approaching_intersection(Vehicle1, Intersection).

exception_priority(Vehicle2, Vehicle1, Intersection) :-
  rail_vehicle(Vehicle2),
  approaching_intersection(Vehicle2, Intersection),
  approaching_intersection(Vehicle1, Intersection).

exception_priority(Vehicle2, Vehicle1, Intersection) :-
  on_priority_road(Vehicle2, Intersection),
  approaching_intersection(Vehicle1, Intersection).

exception_priority(Vehicle2, Vehicle1, Intersection) :-
  has_stop_sign(Vehicle1, Intersection),
  approaching_intersection(Vehicle2, Intersection).

exception_priority(Vehicle2, Vehicle1, Intersection) :-
  has_yield_sign(Vehicle1, Intersection),
  approaching_intersection(Vehicle2, Intersection).

exception_priority(Vehicle2, Vehicle1, Intersection) :-
  entering_from_side_lane(Vehicle2, Intersection),
  flowing_traffic(Vehicle1, Intersection).

exception_priority(Vehicle2, Vehicle1, Intersection) :-
  Bicycle = Vehicle2,
  leaving_cycle_path(Bicycle, Intersection),
  flowing_traffic(Vehicle1, Intersection).


% Prohibited overtaking 
% StVO §16
% A driver must only overtake if it is save and if he can ensure to not violate speeding limits, still needing as little time as possible
% no overtaking signs

violation(Vehicle, overtaking_at_no_overtaking_sign) :-
  overtakes(Vehicle, _),
  no_overtaking_sign(Road).

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
  insufficient_speed_difference(Vehicle1, Vehicle2).

speed_difference_too_small(Follower, Leader) :-
  speed(Follower, SpeedFollower),
  speed(Leader, SpeedLeader),
  (SpeedFollower - SpeedLeader) < 20.

violation(Vehicle, overtaking_unsafe_reentry) :-
  overtakes(Vehicle, O),
  not safe_reentry_after_overtake(Vehicle, O).

violation(Vehicle, overtaking_insufficient_visibility) :-
  overtakes(Vehicle, _),
  not sufficient_visibility(Vehicle).
