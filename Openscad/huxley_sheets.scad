include <configuration.scad>
use <huxley_gears.scad>

use <belt-clamp.scad>
use <x-idler-bracket.scad>
use <x-motor-bracket.scad>
use <pla_coupling.scad>
use <y-brackets-split.scad>


module upplate1(){
	translate([100,0,0]) rotate([0,0,90])
	union()
	{

		translate([66,8,0]) rotate([0,0,0]) x_motor_body();

		//translate([80,67,0]) rotate([0,0,90]) import_stl("../stl/x-carriage.stl");
	for(i=[0,1,2,3]){
		translate([82,20*i+24,0]) rotate([0,0,-90]) import_stl("../stl/y-bar-clamp.stl");
		translate([96,20*i+24,0]) rotate([0,0,-90]) import_stl("../stl/y-bar-clamp.stl");
	}//end for
	translate([5,30,0]) rotate([0,0,90]) coupling(1);
	translate([5,85,0]) rotate([0,0,90]) coupling(0);
	translate([35,105,0]) rotate([0,0,0]) coupling(1);
	translate([70,105,0]) rotate([0,0,0]) coupling(0);
	}//end union
}

module upplate2(){
translate([94,5,0]) rotate([0,0,90]) union()
	{
		translate([0,17,0]) rotate([0,0,-120]) import_stl("../stl/frame-vertex-foot.stl");
		translate([5,73,0]) mirror([0,1,0]) rotate([0,0,240]) import_stl("../stl/frame-vertex-foot.stl");

		translate([112,60,0]) rotate([0,0,90]) x_idler_body();

		translate([64,74,0]) rotate([0,0,0]) import_stl("../stl/idler-cover.stl");

		translate([17,44,0]) rotate([0,0,0]) import_stl("../stl/bed-spring.stl");
		translate([17,17,0]) rotate([0,0,0]) import_stl("../stl/bed-spring.stl");
		translate([-2,28,0]) rotate([0,0,0]) import_stl("../stl/spring-anchor-double.stl");
		translate([50,60,0]) rotate([0,0,180]) import_stl("../stl/spring-anchor-single.stl");
	}
}
module upplate3(){
	translate([0,0,0]) rotate([0,0,0]) union()
	{
		translate([58,70,0]) rotate([0,0,-90]) import_stl("../stl/nozzle-mounting.stl");
		translate([27,20,16]) rotate([180,0,0]) small_gear();
		translate([-10,70,0]) rotate([0,0,0]) large_gear();
		translate([60,20,0]) rotate([0,0,0]) import_stl("../stl/M4-Block.stl");
		translate([80,30,0]) rotate([0,0,90]) import_stl("../stl/idler-bracket.stl");
	}
}
module upplate4(){
	translate([0,0,0]) rotate([0,0,0]) union()
	{
		translate([19,83,0]) rotate([0,0,0]) import_stl("../stl/bearing-holder.stl");
		translate([39,83,0]) rotate([0,0,0]) import_stl("../stl/bearing-holder.stl");
		translate([19,63,0]) rotate([0,0,0]) import_stl("../stl/bearing-holder.stl");
		translate([39,63,0]) rotate([0,0,0]) import_stl("../stl/bearing-holder.stl");

		translate([86,52,0]) rotate([0,0,90]) import_stl("../stl/x-carriage.stl");

		translate([40,0,0]) rotate([0,0,90]) import_stl("../stl/z-motor-bracket.stl");
		translate([97,0,0]) rotate([0,0,90]) import_stl("../stl/z-motor-bracket.stl");

		translate([7,55,0]) rotate([0,0,90]) beltclamp();
		translate([-5,55,0]) rotate([0,0,90]) beltclamp();
	}
}
module upplate5(){
	translate([90,0,0]) rotate([0,0,90]) union()
	{
		//translate([20,-5,0]) rotate([0,0,0]) import_stl("../stl/z-motor-bracket.stl");
		//translate([20,50,0]) rotate([0,0,0]) import_stl("../stl/z-motor-bracket.stl");

		translate([30,40,0]) rotate([0,0,120]) import_stl("../stl/frame-vertex.stl");
		translate([36,76,0]) rotate([0,0,105]) import_stl("../stl/frame-vertex.stl");

		translate([28,0,0]) rotate([0,0,0]) import_stl("../stl/y-idler-bracket.stl");
		translate([34,77,0]) rotate([0,0,-45]) import_stl("../stl/y-motor-bracket.stl");
		translate([90,50,0]) mirror([0,1,0]) rotate([0,0,140]) import_stl("../stl/frame-vertex-foot.stl");
		translate([73,15,0]) rotate([0,0,-20]) import_stl("../stl/frame-vertex-foot.stl");
	}
}
module upplate6(){
//use this for y brackets with no support material
translate([0,0,0]) rotate([0,0,0]) union()
	{
translate([0,50,0])
	idler_split1();
idler_split2();

translate([35,25,0])
	motor_split1();
translate([30,75,0])
	motor_split2();
	}
}

platenum=4;
%cube(size=[130,130,0.01],center=true);
if(platenum==1)
	translate([-43,-49,0]) upplate1();
if(platenum==2)
	translate([-44,-49,0]) upplate2();
if(platenum==3)
	translate([-44,-49,0]) upplate3();
if(platenum==4)
	translate([-44,-49,0]) upplate4();
if(platenum==5)
	translate([-44,-49,0]) upplate5();
if(platenum==6)
	translate([-44,-49,0]) upplate6();
if(platenum==99){
%translate([140,0,0]) cube(size=[130,130,0.01],center=true);
%translate([280,0,0]) cube(size=[130,130,0.01],center=true);
%translate([420,0,0]) cube(size=[130,130,0.01],center=true);
%translate([560,0,0]) cube(size=[130,130,0.01],center=true);
	translate([-43,-49,0]) upplate1();
	translate([104,-49,0]) upplate2();
	translate([244,-49,0]) upplate3();
	translate([384,-49,0]) upplate4();
	translate([524,-49,0]) upplate5();
}