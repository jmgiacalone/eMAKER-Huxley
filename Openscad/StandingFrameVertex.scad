/* This vertex is based on the following:
 * Standing parametric Frame Vertex for mini-mendel with anti vibration feet.
 * By Erik de Bruijn <info@erikdebruijn.nl>
 * GPLv2 or later
 * Description: frame vertex for eMAKER Huxley
*/

// //////////////////////////////
// USER PARAMETERS
// //////////////////////////////

feet_on = true;
m=0;
hole_size=6.3;
vhole_size=6.3;
hhole_size=6.1;
nX =1;
nY =1;
spacing_X=0;
spacing_Y=0;

spool_foot=0;//0=vertex,1=simple spool foot,2=spool foot with cable clip

angle = 120;
tilt = 0;
seg1_H=26;
seg2_H=26;
amount_with_foot = 4;
n = 0;


// uncomment for printing:
print(feet_on,spool_foot,m);

// uncomment for viewing/editing
//vertex();

// //////////////////////////////
// OpenSCAD SCRIPT
// //////////////////////////////

module print(feet_on,spool_foot,m)
{
//echo($fa);
$fn=45;
$fa=2;
mirror([m,0,0])
{
  for(x=[1:nX])
  {
    for(y=[1:nY])
    {
//echo ((nX*(x-1)+nY*(y-1)));
      //nn = (y+(x-1)*nY);
      //echo (nn);//number
      //if(nn<amount_with_foot) feet_on = false;
      translate([x*spacing_X,y*spacing_Y,14])
      rotate([-90,180+tilt,0])
      {
      vertex(feet_on,spool_foot);
      }
    }//for y
  }//for x
}}
module vertex(feet_on,spool_foot)
{
difference()
{
  // Positive:
  vertex_foot(feet_on,spool_foot);

  // Negative:
  translate([17.515,-14/2,12.76]) rotate([0,180+45-tilt,0]) 
  {
    //translate([-1.62,0,1.62])cube([3,16.01,3], center=true);
    rotate([90,0,0])
	//#cylinder(r=3.15,h=20,center=true);
	polyhole(20,hole_size);
  }
  translate([-1.575,-14/2,45.77]) //cube([6.3,16.3,6.3],center=true);
  rotate([0,180+45-tilt,0]) 
  {
   //translate([-1.62,0,1.62])cube([3,16,3], center=true);
      rotate([90,0,0])
	//#cylinder(r=3.15,h=20,center=true);
	polyhole(20,hole_size);
  }

  //===== cylindrical holes sideways ==
  translate([-1.575,-14/2,45.77]) rotate([0,30,0]) 
    translate([7.2,0,0])
    {
       //translate([1.82,0.1,0]) rotate([0,0,45])cube([3,3,16], center=true);
       translate([0,3.15*sin(45),0]) rotate([0,0,45])cube([3.15,3.15,16], center=true);
  	//#cylinder(r=3.15,h=16.01,center=true);
	polyhole(16.01,hole_size);
	// make sure the brace doesn't interfere with the washer/nut.
  	translate([0,0,-9.4]) #cylinder(r=7,h=5,center=true);
    }

  //===== cylindrical holes sideways ==
if(spool_foot==0)
{
  translate([17.515,-14/2,12.76+14]) rotate([0,90,0]) 
    translate([7.2,0,0])
    {
        //translate([1.82,0.1,0]) rotate([0,0,45])#cube([3,3,16], center=true);
       translate([0,3.15*sin(45),0]) rotate([0,0,45])cube([3.15,3.15,16], center=true);
  	//#cylinder(r=3.15,h=16.01,center=true);
	polyhole(16.01,hole_size);
	// make sure the brace doesn't interfere with the washer/nut.
  	translate([0,0,-9.4]) #cylinder(r=7,h=5,center=true);
    }
}
  // middle cutout
  rotate([0,-angle,0]) translate([22,1,-seg2_H-3]) rotate([90,-angle,0])
	//#cylinder(r=3.5,h=16);
	polyhole(36,hole_size);
  //translate([15,1,seg1_H+6]) rotate([90,0,0]) #cylinder(r=3.5,h=16);

}

} // module vertex

module vertex_foot(feet_on,spool_foot)
{
      amount_with_foot=amount_with_foot-1;
	difference()
	{
	union()
	{
		// I overlapped my own design with eD's version to visually check they are (mostly) identical! This is a fidly technique but gives a good result.
		//translate([10,0,30]) rotate([90,0,0]) import_stl("Desktop/minimendel-vertex.stl", convexity = 5);
		
		//===== cylindrical holes
		translate([17.515,-14/2,12.76]) rotate([90,0,0]) 
			//cylinder(r=7,h=14.01,center=true);
			polyhole(14.01,14);
		
if(spool_foot==0)
{
		translate([-1.575,-14/2,45.77]) rotate([90,0,0]) 
			//cylinder(r=7,h=14.01,center=true);
			polyhole(14.01,14);
		
		//===== bars
		translate([17.515,-14/2,12.76+seg1_H/2]) 
		  cube([14,14,seg1_H],center=true);
		translate([-1.575,-14/2,45.77]) 
		  rotate([0,-angle/2,0]) translate([0,0,-seg2_H/2]) 
			cube([14,14,seg2_H],center=true);
		
		//braces
		translate([-1.575,-14/2,45.77]) 
		  rotate([0,-angle/4,0]) translate([7,0,-seg2_H+6]) 
			cube([14,14,12],center=true);
}		
		// foot
		if(feet_on==true)
		{
			difference()
			{
				  translate([12.5,-14,-2]) cube([10,14,12]);
				  translate([15,-14,1]) cube([5,14,6]);
			}
		}
if(spool_foot==2)
{
		  translate([12.5,-14,18])
			difference()
			{
				cube([10,14,10]);
				union()
				{
					translate([5,7,2]) cube([24,7,3.3]);
					translate([-7,7,2.4]) cube([24,8,2.5]);
				}
			}
}
		// small pad to make it printable in the tilted orientation!
		//translate([-4,-14,50]) rotate([0,-tilt,0]) translate([-4,0,0]) cube([8,14.01,2.5]);
	}
		translate([-1.575,-14/2,45.77]) 
		  rotate([0,-angle/4,0]) translate([22,0,-seg2_H+6]) 
			cube([14,14,24],center=true);
	}
}
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), center = true, $fn = n);
}
