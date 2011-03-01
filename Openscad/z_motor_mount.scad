include <parameters.scad>;
use <library.scad>;
hw= 38.105;
l=64;
module basic_vertex()
{
	rotate([0,0,0])
	difference()
	{
		translate([0,l/2-partthick/2,0]) union()
		{
			translate([0,-l/2,-partthick/2])
				cube([hw/2+partthick/2,l,partthick/2]);
			translate([0,-l/2,-partthick/2])
				cube([hw/2,l,partthick]);
			translate([hw/2,0,0]) rotate([90,0,0])
				cylinder(h=l, r=partthick/2, center=true);
		}
		holes();
	}
}
module holes() 
{
	rotate([90,0,0]) translate([hw/2,0,0])
	union()
	{
	//teardrop
	rotate([0,0,30])
		translate([-7,0,0])
			rotate([90,90,0])
				rod( rodsize * 15,rodsize/2);
	//holes
	rotate([0,0,-90]) translate([0,0,-l/4]) teardrop(r = rodsize/2, h =l * 1.5, truncateMM = 1);//rod(rodsize * 15);
	}
}
module NEMA14mount(depth=20,ia=0)
{
	translate([0,0,depth]) cube([nema14_square,nema14_square,depth], center=true);
	polyhole(depth,nema14_hub);
	for(a = [0:3])
	{
		rotate([0,0,a*90+ia])
			translate([nema14_screws/2,nema14_screws/2,0]) polyhole(depth,3.3);
	}
	
}

module rod_trap(depth=20)
{
	polyhole(depth,rodsize);
	translate([(hw+partthick)/2,0,0]) cube([hw+partthick,rodsize*0.7,depth], center = true);
}
module z_mount(left = false) 
{
	color(c)
	difference()
	{
		union()
		{
			basic_vertex();
			mirror([1,0,0])
				basic_vertex();
		}
		union()
		{
			//translate([0,partthick,partthick*0.1]) cube([partthick*2,partthick*1.1,partthick*1.2], center=true);
			translate([0,32-partthick/2,partthick*0.1]) cube([partthick*2,partthick,partthick*1.2], center=true);
			translate([0,32-partthick/2,3]) cube([partthick,partthick*2,partthick], center=true);
		}
		translate([-partthick*0.75,l-7-partthick/2,partthick*0.1])
			cube([rodsize*1.2,rodsize,partthick*1.2], center=true);
		translate([0,32-partthick/2,-5]) NEMA14mount();
		translate([0,l-7-partthick/2,0]) rod_trap();
	}
}

z_mount(left=true);




