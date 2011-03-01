include <parametric_involute_gear_v5.0.scad>

small_gear();
large_gear();

module small_gear(){
translate ([0,0,0]) difference(){
	gear (
	number_of_teeth=9,
	circular_pitch=200, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=7,
	rim_thickness=7,
	rim_width=5,
	hub_thickness=15,
	hub_diameter=12,
	bore_diameter=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0);
	translate([0,0,11]) rotate([0,90,0]) cylinder(h=6,r=2.7/2,$fn=30);
}}

module large_gear(){
translate ([34.444,0,0]) difference(){
	gear (
	number_of_teeth=53,
	circular_pitch=200, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=5,
	rim_thickness=6,
	rim_width=3,
	hub_thickness=12,
	hub_diameter=15,
	bore_diameter=4,
	circles=6,
	backlash=0,
	twist=0,
	involute_facets=0);
	translate([0,0,12]) cylinder(h=4, r=7.4/2,$fn=6,center=true);
}}