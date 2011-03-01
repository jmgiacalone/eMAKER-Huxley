include <parameters.scad>;
use <library.scad>;
vertexoffset=27.713;
module basic_vertex() 
{
	difference() 
	{
		union() 
		{
			for(side = [1, -1]) 
			{
				rotate([0, 0, side * 30]) translate([0, vertexoffset, 0]) 
				{
					cube([partthick, partthick, partthick], center = true);
					translate([side * -rodsize, 0, 0]) 
						cylinder(h = partthick, r = partthick / 2, center = true, $fn = fn);
				}
			}
			translate([0, partthick, 0]) 
				difference() 
				{
					rotate_extrude(convexity = 10, $fn = fn) 
						translate([vertexoffset - partthick * sqrt(3) / 2, 0, 0]) square(size = partthick, center = true);
					for (side = [1, -1]) 
						rotate([0, 0, side * 30])
							 translate([-side * vertexoffset, 0, 0]) 
								cube(vertexoffset * 2, center = true);
				}
		}
		union()
		{
			for(side = [1, -1]) 
			{
				rotate([90, 0, side * 30])
					translate([0, 0, -rodsize * 7.5]) 
						rotate([0, 0, -90])
							teardrop(r = rodsize/2, h = rodsize * 15, truncateMM = 1);//rod(rodsize * 15);
				rotate([0, 0, side *30]) 
				{
					translate([-side * rodsize, vertexoffset, 0]) 
						rod(partthick * 2);
				}
			}
			translate([0,vertexoffset + rodsize/4]) polyhole(partthick*1.2, rodsize);
		}
	}
}

module with_foot_and_shelf()
{
	difference()
	{
	union()
	{

		union()
		{
			basic_vertex();
		
			// Simple foot
			rotate([0,0,-30]) translate([partthick*1.3,2.3*partthick,0])
				difference()
				{
					translate([0,0, 0]) 
							cube([partthick,partthick*0.6,partthick], center=true);
					translate([partthick*0.1,0, 0]) 
							cube([partthick/3,partthick*0.4/2,partthick], center=true); 
				}
		}
	}

	}
}

module frame_vertex(foot = false, left = false) 
{
	color(c)
	if(!foot)
		basic_vertex();
	else
	{
		//if(left)
			with_foot_and_shelf();
		//else
			mirror([0,1,0])
				with_foot_and_shelf();
	}
}

translate([0,0,partthick/2]) frame_vertex(foot = false, left=false);




