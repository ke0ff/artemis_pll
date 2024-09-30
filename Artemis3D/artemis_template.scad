// OpenSCAD 2019.05
// Artemis PCB/heatsink machining template, REV-002
// Joe Haas, KE0FF, 10/28/2023
//
// Rev-002, 09/29/2024
//	Added artefacts for external 5V regulator
//	Adde SMA centerline markers
//
// Rev-001, 10/28/2023
//	initial code

//----------------------------------------------------------------------------------------------------------------------
// User defined parameters.  Modify these to suit a particular application
// NOTE: All data in this file is in mm
//----------------------------------------------------------------------------------------------------------------------
// parametric variables:

thick = 1;
m2m = 25.4/1000; // mils to mm

x0 = 992;
y0 = 700;
hdia = 2.4; //.07*25.4;

width = ((2563-y0)*m2m) + (1000*m2m);
length = (2732-x0)*m2m;

m1x = (1110-x0)*m2m;
m1y = (2000-y0)*m2m;
m2x = m1x;
m2y = (1325-y0)*m2m;
m3x = (2615-x0)*m2m;
m3y = (1325-y0)*m2m;
m4x = m3x;
m4y = (2440-y0)*m2m;
d1x = (1299.5-x0)*m2m;
d1y = (2467-y0)*m2m;
d3x = (2640-x0)*m2m;
d3y = (887-y0)*m2m;
d4x = (2425-x0)*m2m;
d4y = (1232.5-y0)*m2m;
l2x = (1599-x0)*m2m;
l2y = (1533-y0)*m2m;
c60x = (1955-x0)*m2m;
c60y = (1935-y0)*m2m;
c57x = (1935-x0)*m2m;
c57y = (1510-y0)*m2m;
smay = 886*m2m;

genx = 500*m2m;
geny = 300*m2m;

////////////////////////////////////////////////////////////////////////////////

template();
//elipse();

////////////////////////////////////////////////////////////////////////////////


//
//
//**************************************************
				//****************\\
				//    modules     \\
				//    follow      \\
				//****************\\
//**************************************************
//
//
///////////////
// template

module template(){
	difference(){
		// main shape
		union(){
			cube([length,width,thick]);
			// d3 overhang
			translate([d3x,d3y,0]) rotate([0,0,90]) elipse(ww=400*m2m, ll=15, tt=1);
			// d1 overhang
			translate([d1x,d1y,0]) rotate([0,0,0]) elipse(ww=400*m2m, ll=15, tt=1);
		}
		// mtg holes
		translate([m1x,m1y,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([m2x,m2y,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([m3x,m3y,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([m4x,m4y,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		// VREG mtg
		translate([length/2,2400*m2m,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		// reg-module generic mtg
		translate([(length/2)-genx,(2400*m2m)-geny,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([(length/2)-genx,(2400*m2m)+geny,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([(length/2)+genx,(2400*m2m)-geny,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([(length/2)+genx,(2400*m2m)+geny,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		// sma centerline
		translate([100*m2m,smay,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		translate([length-(100*m2m),smay,-1]) cylinder(r=hdia/2, h=3*thick, $fn=32);
		// d1
		translate([d1x,d1y,-1]) elipse(ww=156*m2m, ll=9);
		// d3
		translate([d3x,d3y,-1]) rotate([0,0,90]) elipse(ww=156*m2m, ll=9);
		// d4
		translate([d4x,d4y,-1]) rotate([0,0,90]) elipse(ww=156*m2m, ll=9);
		// l2
		translate([l2x,l2y,-1]) rotate([0,0,90]) elipse(ww=156*m2m, ll=5);
		// c60
		translate([c60x,c60y,-1]) rotate([0,0,90]) elipse(ww=156*m2m, ll=7.5);
		// c57
		translate([c57x,c57y,-1]) rotate([0,0,0]) elipse(ww=156*m2m, ll=7.5);
	}
}

module elipse(ww=10, ll=20, tt=3*thick){
	translate([(ll-ww)/2,0,0]) cylinder(r=ww/2, h=tt, $fn=32);
	translate([-(ll-ww)/2,0,0]) cylinder(r=ww/2, h=tt, $fn=32);
	translate([-(ll-ww)/2,-ww/2,0]) cube([(ll-ww), ww, tt]);
}

/////////////////////////////////////
// generic countersink

module cs(screw=4){
	if(screw == 2){
		translate([0,0,.6]) cylinder(r1=4.57/2, r2=2.18/2, h=1.5, $fn=32, center = true);	// #2 countersinks
	}else{
		translate([0,0,.78]) cylinder(r1=6.02/2, r2=2.84/2, h=2, $fn=32, center = true);	// #4 countersinks
	}
}
/////////////////////////////////////
// SMA connector (fit check artifact)
module sma(){
  union(){
	translate([-4.75,0,-4.6]) cube([9.5,6.7,7.9]);
	translate([0,0,-.75]) rotate([90,0,0]) cylinder(r=3.1, h=7.5, $fn=32);
  }
}

/////////////////////////////////////////////////////
// SMA pilot holes and clearences (part of 3D render)

module sma_pilot(){
	translate([-30.05,-37.7,-6.4]) union(){
		translate([7.75-1.45,-1,-4.1]) cube([12.5,5,7.9]);											// panel face clearance, RF4
		translate([13.3,-.9,-.75]) rotate([90,0,0]) cylinder(r=3.5, h=4.3, $fn=32, center=false);	// barrel pilot, RF4
//		translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
		translate([7.75+(47-13.45),-1,-4.1]) cube([12.5,5,7.9]);									// panel face clearance, RF3
		translate([47.5,-.9,-.75]) rotate([90,0,0]) cylinder(r=3.5, h=4.3, $fn=32, center=false);	// barrel pilot, RF3
//		translate([47,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
	}
}

/////////////////////////////////////////////////
// Side-mount SMA pilot holes (part of 3D render)

module sma2_pilot(){
  translate([-32,-21+38.2,-6.4]) rotate([0,0,270]) union(){
	translate([7.50,0,-4.1]) cube([12,5,7.9]);
	difference(){	// slope roof
		translate([8.25+5.25,width+.035,-4.1]) rotate([0,90,0]) cylinder(h=12, r=width+.4, $fn=256, center=true);
		translate([6.9,-2,-(width*2)-3-4.1]) cube([15,(width*2)+10,(width*2)+10]);
		translate([6.9,3,-4.1]) cube([15,(width*2)+10,(width*2)+10]);		
	}
	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);
//	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
  }
}

/////////////////////////
// scant opening for PBSW

module pbsw(hole=0){
  union(){
	if(hole == 0){
		color("darkslategray",1.0) translate([-3.05,-3.05,0]) cube([6.1,6.1,3.4]);
		color("black",1.0) translate([0,0,0]) cylinder(r=1.7, h=5, $fn=32, center=false);
		color("white",.5) translate([0,0,0]) cylinder(r=.5, h=20, $fn=32, center=false);
	}else{
		translate([0,0,-.1]) cylinder(r=4/2, h=10, $fn=32, center=false);
	}
  }
}

/////////////////////////////
// USB connectors (fit check)

module usb(){
  union(){
	color("silver",1.0) translate([-3.75,-1.1,0]) cube([7.5,5.8,2.5]);
  }
}

/////////////////////
// generic pilot hole

module pilot(diameter=2){
  union(){
	rotate([90,0,0]) cylinder(d=diameter, h=10, $fn=32, center=true);
  }
}

/////////////////////////
// DB9 cutout (3D render)

module db9(){
	translate([0,0,2.05]) union(){
		translate([0,0,0]) cube([18.44,10.06,15], center=true);								// DB9 cutout
		translate([0,0,3.0]) cube([32,14,10.1], center=true);								// DB9 CM
		translate([(101.60-76.20)/2,0,0]) cylinder(r=1.6, h=20, $fn=32, center=true);		// db9 mtg holes,	#1
		translate([-(101.60-76.20)/2,0,0]) cylinder(r=1.6, h=20, $fn=32, center=true);		//				    #2
	}
}

/////////////////////////
// lid corner

module corner(height=5){
			translate([0,0,chamfer]) cylinder(r=crad/2, h=height-chamfer, $fn=32, center=false);			// corner
			cylinder(r1=(crad/2)-chamfer, r2=crad/2, h=chamfer, $fn=32, center=false);
}

/////////////////////////
// debug artifacts
//
// X-rulers
//#translate([-.69,0,0]) cube([0.01,30,50]);	// ruler
//#translate([175.41,0,0]) cube([0.01,30,50]);	// inside main void ruler 1
//#translate([1.67,0,0]) cube([0.01,30,50]);	// inside main void ruler 2
//#translate([175.34,0,0]) cube([0.01,30,50]);	// outside shroud ruler 2
// Y-rulers
//#translate([0,23.81,0]) cube([180,0.01,50]);	// ruler
//#translate([0,22.36 ,0]) cube([180,0.01,50]);	// ruler
// Z-rulers
//#translate([0,0,0]) cube([10,40,.01]);	// ruler
//#translate([0,0,2.04]) cube([9,40,.01]);	// ruler

// EOF
