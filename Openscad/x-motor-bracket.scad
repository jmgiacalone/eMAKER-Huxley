include<configuration.scad>;
use<bushing.scad>
//bushing_height=8;
//socket_width=8;
//socket_depth=4;
//socket_clearance=0.2;
//bushing_width=12;
//bushing_rodsize=6.3;
//bearing_length=4;
//body_chamfers=1;
//rod_clearance=1;//dia
//partthick=12;

//body
module x_motor_body()
{
	difference(){
		union(){
		translate([0,0,0]) rotate([0,0,90]) import_stl("../stl/x-motor-bracket_.stl");
		translate([-2.5,48,20.15]) rotate([90,0,90])
			bushing(true,10);
		translate([-53.5,48,20.15]) rotate([90,0,90])
			bushing(true,10);
		}
		translate([0,48,13.15]) rotate([90,0,90])
			cylinder(h=10,r=2.7/2, $fn=8);
		translate([-46.5,48,13.15]) rotate([90,0,-90])
			cylinder(h=10,r=2.7/2,$fn=8);
	}
}
//bushing holder socket
module bushing_socket()
{
	difference()
	{
		//positive
		union()
		{
			//body
			translate([0,socket_depth/2+6,0]) cube([socket_width+socket_clearance,socket_depth+socket_clearance,bushing_height+socket_clearance],center=true);
			translate([0,bushing_width/4,0]) cube([bushing_width,bushing_width/2+socket_clearance,bushing_height+socket_clearance],center=true);
			//screw hole
			translate([0,bushing_width/2+socket_depth,0]) rotate([-90,0,0])
				cylinder(h=socket_depth*1.6,r=2.7/2, $fn=8);
		}
		//negative
		//chamfers
		for(j=[0,1])
		{
			mirror([j,0,0]) union()
			{
				translate([bushing_width/2+socket_clearance/2,(bushing_width+socket_clearance)/2,0]) rotate([0,0,45]) cube([body_chamfers*sqrt(2),body_chamfers*sqrt(2),(bushing_height+socket_clearance)*2],center=true);
				translate([socket_width/2+socket_clearance/2,(bushing_width+socket_clearance)/2+socket_depth,0]) rotate([0,0,45]) cube([body_chamfers*sqrt(2),body_chamfers*sqrt(2),(bushing_height+socket_clearance)*2],center=true);
			}
		}
	}
}

x_motor_body();
