include<configuration.scad>;
use<library.scad>

bushing_height=8;
socket_width=8;
socket_depth=4;
bushing_width=12;
bushing_rodsize=6.5;
bearing_length=4;
body_chamfers=1;
rod_clearance=1;//dia

side=0;

module ptfe_bushing(a=45,b=0,c=10)
{
//body
difference()
{
	//positive
	union()
	{
		translate([0,socket_depth/2+6,bushing_height/2]) cube([socket_width,socket_depth,bushing_height],center=true);
		translate([0,bushing_width/4,bushing_height/2]) cube([bushing_width,bushing_width/2,bushing_height],center=true);
		//cylinder(h=bushing_height,r=bushing_width/2);
		polyhole(bushing_height,bushing_width);
	}
	//negative
	union()
	{
		//groove
		translate([0,0,(bushing_height-bearing_length)/2])
			//cylinder(h=bushing_height-bearing_length,r=bushing_rodsize/2+2);
			polyhole(bushing_height-bearing_length,bushing_rodsize+2);
		//cylinder(h=bushing_height, r=bushing_rodsize/2+rod_clearance);
		polyhole(bushing_height, bushing_rodsize+rod_clearance);
		//groove chamfer
		translate([0,0,bushing_height-(bushing_height-bearing_length)/2])
			cylinder(h=(bushing_height-bearing_length)/2, r1=bushing_rodsize/2+1, r2=bushing_rodsize/2+rod_clearance/2);
		//opening
		for(i=[1,-1])
		{
			rotate([0,0,i*c-a]) translate([bushing_width*1.5/4,-bushing_width*1.5/4,bushing_height*1.2/2])
				cube([bushing_width*1.5/2,bushing_width*1.5/2,bushing_height*1.2],center=true);
		}
		//body chamfers
		for(j=[0,1])
		{
			mirror([j,0,0]) union()
			{
				translate([bushing_width/2,bushing_width/2,0]) rotate([0,0,45]) cube([body_chamfers*sqrt(2),body_chamfers*sqrt(2),bushing_height*2],center=true);
				translate([socket_width/2,bushing_width/2+socket_depth,0]) rotate([0,0,45]) cube([body_chamfers*sqrt(2),body_chamfers*sqrt(2),bushing_height*2],center=true);
			}
		}
		//screw hole
		translate([0,(bushing_rodsize+rod_clearance)/2+1.5,bushing_height/2]) rotate([-90,0,0])
			cylinder(h=socket_depth*1.6,r=2.7/2, $fn=8);
	}
}
//key
difference()
{
	rotate([0,0,b]) translate([0,(bushing_rodsize+2)/4,bushing_height/2])
		cube([3,(bushing_rodsize+2)/2,bushing_height], center=true);
	cylinder(h=bushing_height, r=bushing_rodsize/2+rod_clearance/2);
}
}//end module ptfe_bushing

if(side==1)
{
	ptfe_bushing(130,-90,0);
}else{
	ptfe_bushing();
}
