use <library.scad>;

module test()
{
	translate([0,0,2])
	difference()
	{
	translate([8,0,0])
	difference()
	{
		union()
		{
			translate([-4.5,0,0])cube([5,9,4], center=true);
			translate([-2,0,0]) cylinder(h=4,r=4.5,center=true);
		}
		translate([-3,0,0]) polyhole(6,6);
	}
	translate([0,0,1]) cube([2,12,3], center=true);
	}
}

test();
mirror([1,0,0]) test();