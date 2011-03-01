include<configuration.scad>;
use<library.scad>
bushing_height=8;
socket_width=8;
socket_depth=4;
socket_clearance=0.2;
bushing_width=12;
bushing_rodsize=6.3;//dia
bearing_length=4;
body_chamfers=1;
rod_clearance=1;//dia
partthick=12;
x_rod_spacing=30;

idler_body_length=37.5;
idler_body_width=62;
corner_radius=4;

module x_idler_body()
{
	difference()
	{
		//positive
		union()
		{
			//body
			translate([0,0,0]) cube([idler_body_length,idler_body_width,partthick], center=true);
			//bushing socket block
			for(i=[0,1])
			{
				mirror([0,i,0]) translate([-idler_body_length/2,idler_body_width/2-(bushing_height+socket_clearance+2),partthick/2])
					cube([bushing_width+socket_clearance+2,bushing_height+socket_clearance+2,3]);
			}
		}
		//negative
		for(i=[0,1])
		{
			mirror([0,i,0]) union()
			{
				//rod holes
				translate([-idler_body_length/2+8,x_rod_spacing/2,0]) rotate([90,0,90]) teardrop(bushing_rodsize/2, idler_body_length, -90);
				//tensioning holes
				translate([-idler_body_length/2-1,x_rod_spacing/2,0]) rotate([90,0,90]) polyhole(9, m3_dia_clr);
				//M3 socket
				translate([-idler_body_length/2+5,x_rod_spacing/2,0]) rotate([0,90,0])
				union()
				{
					cylinder(h=3.1,r=(5.8*2/sqrt(3))/2,$fn=6);
					translate([-5.8/2,0,1.5]) cube([partthick,5.8,3.1], center=true);
				}
	
				//bushing sockets
				translate([-idler_body_length/2+1+bushing_width/2,idler_body_width/2-bushing_height/2-1,partthick+2])  bushing_socket(i=-90);
				//remove excess material
				translate([corner_radius*2-4,idler_body_width/2-8,-partthick/2]) union()
				{
					cube([idler_body_length/2,idler_body_width/2,partthick]);
					translate([0,corner_radius*2,0]) cylinder(h=partthick,r=corner_radius*2);
					
				}
			}
		}
	}
}
//bushing holder socket
module bushing_socket(i=0,j=0,k=0)
{
	rotate([i,j,k]) difference()
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

//bushing_socket();
x_idler_body();
