// By Erik de Bruijn <reprap@erikdebruijn.nl>
// License: GPLv2 or later
//
// Goal: the goal of this parametric model is to generate a high quality custom timing pulley that is printable without support material.
// NOTE: The diameter of the gear parts are determined by the belt's pitch and number of teeth on a pully.
// updates:
// numSetScrews allows you to specify multiple set screws, 1 or 3 are useful values. With 3 you will be able to center the axis.

// //////////////////////////////
// USER PARAMETERS
// //////////////////////////////

// Pulley properties
shaftDiameter = 8.29; // the shaft at the center, will be subtracted from the pulley. Better be too small than too wide.
hubDiameter = 0; // if the hub or timing pulley is big enough to fit a nut, this will be embedded.
hubHeight = 0; // the hub is the thick cylinder connected to the pulley to allow a set screw to go through or as a collar for a nut.
flanges =16; // the rims that keep the belt from going anywhere
hubSetScewDiameter = 2.4; // use either a set screw or nut on a shaft. Set to 0 to not use a set screw.
numSetScrews = 0;
numTeeth = 11; // this value together with the pitch determines the pulley diameter
toothType = 2; // 1 = slightly rounded, 2 = oval sharp, 3 = square. For square, set the toothWith a little low.

// Belt properties:
pitch = 5; // distance between the teeth
beltWidth = 6; // the width/height of the belt. The (vertical) size of the pulley is adapted to this.
beltThickness = 0.65; // thickness of the part excluding the notch depth!
notchDepth = 1.8; // make it slightly bigger than actual, there's an outward curvature in the inner solid part of the pulley
toothWidth = 1.4; // Teeth of the PULLEY, that is.

// //////////////////////////////
// Includes
// //////////////////////////////
//<teardrop.scad>
// See the bottom of the script to comment it out if you don't want to use this include!
//

// //////////////////////////////
// OpenSCAD SCRIPT
// //////////////////////////////

PI = 3.15159265;
$fs=0.2; // def 1, 0.2 is high res
$fa=3;//def 12, 3 is very nice

pulleyDiameter = pitch*numTeeth/PI;

if(hubSetScewDiameter >= 1) // set screw, no nut
{
	difference()
{
	timingPulley( pitch,beltWidth,beltThickness,notchDepth,numTeeth,flanges, shaftDiameter,hubDiameter,hubHeight,hubSetScewDiameter);
	//translate([0,0,-2.01]) nut(8.20,8.20);
	// slots for a grub screw
	translate([0,-2.5,10.01]) #cube([16,5,6.1]);
	// slots for a grub screw

// captive M3 nut (5.39mm wide)
//translate([0,0,15]) 	
//translate([3.7,0,3]) cube([4.4,5.25,8],center=true);

//rotate([90,00,30]) cube([5,5.4,8]);
/*	// captive nut
	union()
	{
	translate([0,0,2]) 
		translate([-3,5,0]) 
		rotate([90,00,30]) #nut(3,3);
	translate([0,0,2]) 
		translate([-3,5,3]) 
		rotate([90,00,30]) #nut(3,3);
	}
*/
}
}

if(hubSetScewDiameter == 0) // use a nut
{
if(pulleyDiameter >= hubDiameter) // no hub needed
{
	difference()
	{
		timingPulley(
			pitch,beltWidth,beltThickness,notchDepth,numTeeth,flanges,shaftDiameter,hubDiameter,0,hubSetScewDiameter
		);
		translate([0,0,-6]) nut(8.15,8.15);
	}
}
if(pulleyDiameter < hubDiameter)
{
	difference()
	{
		timingPulley(
			pitch,beltWidth,beltThickness,notchDepth,numTeeth,flanges,shaftDiameter,hubDiameter,hubHeight,hubSetScewDiameter
		);
		translate([0,0,5]) nut(8,12);
	}
}
}

// also in ~/RepRap/Object Files/nuts.scad
module nut(nutSize,height)
{
// Based on some random measurements:
// M3 = 5.36
// M5 = 7.85
// M8 = 12.87
	hexSize = nutSize + 12.67 - 8; // only checked this for M8 hex nuts!!
hexSize = 9.91;//8.81 for M6 nut
	union()
	{
		 for(i=[0:5])
		{
			intersection()
			{
				rotate([0,0,60*i]) translate([0,-hexSize/2,0]) cube([hexSize/2,hexSize,height]);
				rotate([0,0,60*(i+1)]) translate([0,-hexSize/2,0]) cube([hexSize/2,hexSize,height]);
			}
		}
	}
}


module timingPulley(
	pitch, beltWidth, beltThickness, notchDepth, numTeeth, flanges, shaftDiameter, hubDiameter, hubHeight, hubSetScewDiameter
) {
	totalHeight = beltWidth + flanges + hubHeight;

	difference()
	{
		union()
		{
			timingGear(pitch,beltWidth,beltThickness,numTeeth,notchDepth,flanges);
			hub(hubDiameter,hubHeight,hubSetScewDiameter);
		}
		#shaft(40,shaftDiameter);
	}




	module shaft(shaftHeight, shaftDiameter)
	{
		cylinder(h = shaftHeight, r = shaftDiameter/2, center =true);
	}


	module timingGear(pitch,beltWidth,beltThickness,numTeeth,notchDepth,flanges)
	{
		flangeHeight = 0;
		//if(flanges==1)
		{
			flangeHeight = 2;
		}
		
		toothHeight = beltWidth+flangeHeight*2;
		circumference = numTeeth*pitch;
		outerRadius = circumference/PI/2-beltThickness;
		innerRadius = circumference/PI/2-notchDepth-beltThickness;

		union()
		{
			//solid part of gear
			translate([0,0,-toothHeight]) cylinder(h = toothHeight, r = innerRadius, center =false);
			//teeth part of gear
			translate([0,0,-toothHeight/2]) teeth(pitch,numTeeth,toothWidth,notchDepth,toothHeight);
	
			// flanges:
			if(flanges>=1)
			{
				//top flange
				translate([0,0,0]) cylinder(h = 1, r=outerRadius+1);
				translate([0,0,-flangeHeight]) cylinder(h = flangeHeight, r2=outerRadius+1,r1=innerRadius);
				//bottom flange
				translate([0,0,-toothHeight-0.5]) cylinder(h = 1.6, r=outerRadius+1);
				translate([0,0,-toothHeight]) cylinder(h = flangeHeight, r1=outerRadius,r2=innerRadius);
			}
		}

	}

	module teeth(pitch,numTeeth,toothWidth,notchDepth,toothHeight)
	{
		// teeth are apart by the 'pitch' distance
		// this determines the outer radius of the teeth
		circumference = numTeeth*pitch;
		outerRadius = circumference/PI/2-beltThickness;
		innerRadius = circumference/PI/2-notchDepth-beltThickness;
		echo("Teeth diameter is: ", outerRadius*2);
		echo("Pulley inside of teeth radius is: ", innerRadius*2);
		
		for(i = [0:numTeeth-1])
		{
			rotate([0,0,i*360/numTeeth]) translate([innerRadius,0,0]) 
				tooth(toothWidth,notchDepth, toothHeight,toothType);
		}
	}
	module tooth(toothWidth,notchDepth, toothHeight,toothType)
	{
		if(toothType == 1)
		{
			union()
			{
				translate([notchDepth*0.25,0,0]) 
					cube(size = [notchDepth,toothWidth,toothHeight],center = true);
		  		translate([notchDepth*0.75,0,0]) scale([notchDepth/4, toothWidth/2, 1]) 
					cylinder(h = toothHeight, r = 1, center=true);
			}
		}
		if(toothType == 2)
			scale([notchDepth, toothWidth/2, 1]) cylinder(h = toothHeight, r = 1, center=true);

		if(toothType == 3)
		{
			union()
			{
				#translate([notchDepth*0.5-1,0,0]) cube(size = [notchDepth+2,toothWidth,toothHeight],center = true);
		  		//scale([notchDepth/4, toothWidth/2, 1]) cylinder(h = toothHeight, r = 1, center=true);
			}
		}
	}

	module hub(hubDiameter,hubHeight,hubSetScewDiameter)
	{
		if(hubSetScewDiameter == 0)
		{
			cylinder(h = hubHeight, r = hubDiameter/2, center =false);
		}
		if(hubSetScewDiameter >= 0)
		{
			difference()
			{
				
				cylinder(h = hubHeight, r = hubDiameter/2, center =false);
				for(rotZ=[1:numSetScrews])
					rotate([0,0,360*(rotZ/numSetScrews)]) translate([0,0,3]) rotate([0,90,0]) 
						teardrop(hubSetScewDiameter/2, hubDiameter,true);
			}
		}
	}


}


/* include: module teardrop(radius,height,truncated)
module teardrop(radius,height,truncated)
{
	truncateMM = 1;
	union()
	{
		if(truncated == true)
		{
		intersection()
		{
		translate([0,0,height/2]) scale([1,1,height]) rotate([0,0,180]) cube([radius*2.5,radius*2,1],center=true);
		scale([1,1,height]) rotate([0,0,3*45]) cube([radius,radius,1]);
		}
		}
		if(truncated == false)
		{
		scale([1,1,height]) rotate([0,0,3*45]) cube([radius,radius,1]);
		}
		#cylinder(r=radius, h = height);
	}
}
*/