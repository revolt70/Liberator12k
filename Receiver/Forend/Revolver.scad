include <../../Meta/Animation.scad>;

use <../../Meta/Manifold.scad>;
use <../../Meta/Units.scad>;
use <../../Meta/Debug.scad>;
use <../../Meta/Resolution.scad>;
use <../../Meta/RenderIf.scad>;
use <../../Meta/MirrorIf.scad>;

use <../../Meta/Math/Triangles.scad>;

use <../../Shapes/Components/Cylinder Redux.scad>;
use <../../Shapes/Components/Pump Grip.scad>;

use <../Lower/Lower.scad>;
use <../Lower/Trigger.scad>;

use <../../Shapes/Chamfer.scad>;
use <../../Shapes/Helix.scad>;
use <../../Shapes/Bearing Surface.scad>;
use <../../Shapes/Teardrop.scad>;
use <../../Shapes/TeardropTorus.scad>;
use <../../Shapes/Semicircle.scad>;
use <../../Shapes/ZigZag.scad>;
use <../../Shapes/Components/Pivot.scad>;

use <../../Vitamins/Bearing.scad>;
use <../../Vitamins/Nuts And Bolts.scad>;
use <../../Vitamins/Nuts and Bolts/BoltSpec.scad>;
use <../../Vitamins/Nuts and Bolts/BoltSpec_Metric.scad>;
use <../../Vitamins/Nuts and Bolts/BoltSpec_Inch.scad>;
use <../../Vitamins/Rod.scad>;

use <../Action Rod.scad>;
use <../Receiver.scad>;
use <../Lugs.scad>;
use <../Frame.scad>;
use <../Buttstock.scad>;

use <../FCG/Simple.scad>;

/* [What to Render] */

// Configure settings below, then choose a part to render. Render that part (F6) then export STL (F7). Assembly is not for printing.
_RENDER = "Revolver Assembly"; // ["Revolver Assembly", "Receiver_LargeFrame", "Revolver_RecieverFront", "Revolver_ReceiverBack", "Revolver_FrameSpacer", "Foregrip", "RecoilPlate_Template", "Revolver_CylinderCore_Projection", "Revolver_CylinderCore", "Revolver_CylinderShell", "Revolver_BarrelSupport", "Revolver_ForendSpindleToggleLinkage", "Revolver_ForendSpindleToggleHandle", "Revolver_FrameBack"]
//$t = 1; // [0:0.01:1]

_SHOW_RECEIVER = true;
_SHOW_LOWER_LUGS = true;
_SHOW_LOWER = true;
_SHOW_FCG = true;
_SHOW_STOCK = true;
_SHOW_RECEIVER_FRONT = true;
_SHOW_RECOIL_PLATE = true;
_SHOW_ACTION_ROD = true;
_SHOW_BARREL = true;
_SHOW_BARREL_SUPPORT = true;
_SHOW_CYLINDER = true;
_SHOW_PUMP = true;
_SHOW_SPINDLE = true;
_SHOW_FRAME_SPACER = true;
_SHOW_SHIELD = true;

/* [Assembly Transparency] */
_ALPHA_BARREL_SUPPORT = 1;     // [0:0.1:1]
_ALPHA_CYLINDER = 1;           // [0:0.1:1]
_ALPHA_FOREND = 1;             // [0:0.1:1]
_ALPHA_RECEIVER_TUBE = 1;      // [0:0.1:1]
_ALPHA_RECEIVER_COUPLING = 1;  // [0:0.1:1]
_ALPHA_RECEIVER_FRONT = 1;     // [0:0.1:1]
_ALPHA_RECOIL_PLATE_HOUSING=1; // [0:0.1:1]
_ALPHA_SPINDLE = 1;            // [0:0.1:1]
_ALPHA_FCG = 1;                // [0:0.1:1]

/* [Assembly Cutaways] */
_CUTAWAY_RECOIL_PLATE = false;
_CUTAWAY_BARREL_SUPPORT = false;
_CUTAWAY_CYLINDER = false;
_CUTAWAY_RECEIVER = false;
_CUTAWAY_RECEIVER_FRONT = false;
_CUTAWAY_FOREND = false;
_CUTAWAY_FCG = false;
_CUTAWAY_DISCONNECTOR = false;
_CUTAWAY_HAMMER = false;

/* [Barrel and Cylinder Dimensions] */
BARREL_LENGTH = 15.5;
BARREL_DIAMETER = 1.0001;
BARREL_CLEARANCE = 0.008;

CYLINDER_DIAMETER = 3.501;
CYLINDER_LENGTH = 2.741;
CYLINDER_CLEARANCE = 0.005;
CYLINDER_OFFSET = 1.001;
CHAMBER_LENGTH = 3;
CHAMBER_ID = 0.8101;

/* [Screws] */
GP_BOLT = "#8-32"; // ["M4", "#8-32"]
GP_BOLT_CLEARANCE = 0.015;

FOREGRIP_BOLT = "#8-32"; // ["M4", "#8-32"]
FOREGRIP_BOLT_CLEARANCE = 0.015;

RECOIL_PLATE_BOLT = "#8-32"; // ["M4", "#8-32"]
RECOIL_PLATE_BOLT_CLEARANCE = 0.015;

/* [Branding] */
BRANDING_MODEL_NAME = "ZZR 6x12ga";

$fs = UnitsFs()*0.25;

// Settings: Lengths
function SpindleRadius() = 5/16/2;
function ShellRimLength() = 0.06;
function CylinderGap() = 0.005;
function ChamberLength() = CHAMBER_LENGTH;
function BarrelLength() = BARREL_LENGTH;
function CylinderZ() = -(CYLINDER_OFFSET + ManifoldGap());
function WallBarrel() = 0.375; //0.4375;
function WallSpindle() = 0.1875;
function ForegripGap() = -1.25;
function ActionRodTravel() = 2;
function ReceiverFrontLength() = 0.5;

function ChargingRodOffset() =  0.75+RodRadius(ChargingRod());

function ChamferRadius() = 1/16;
function CR() = 1/16;

// Measured: Vitamins
function BlastPlateThickness() = 1/4;
function BlastPlateWidth() = 1.5;
function RecoilPlateThickness() = 1/4;
function RecoilPlateWidth() = 1.5;
function RecoilSpreaderThickness() = 0.5;

function Revolver_ForendSpindlePinLength() = 1.5;
function Revolver_ForendSpindlePinRadius() = 3/32/2;
function Revolver_ForendSpindlePinClearance() = 0.005;

function Revolver_ForendSpindleTogglePinLength() = 1.5;
function Revolver_ForendSpindleTogglePinRadius() = 3/32/2;
function Revolver_ForendSpindleTogglePinClearance() = 0.005;

function Revolver_ForendSpindleLinkagePinLength() = 1.5;
function Revolver_ForendSpindleLinkagePinRadius() = 3/32/2;
function Revolver_ForendSpindleLinkagePinClearance() = 0.005;

// Settings: Vitamins
function CylinderRod() = Spec_RodFiveSixteenthInch();

function BarrelSetScrew() = BoltSpec(GP_BOLT);
assert(BarrelSetScrew(), "BarrelSetScrew() is undefined. Unknown GP_BOLT?");

function ForegripBolt() = BoltSpec(FOREGRIP_BOLT);
assert(ForegripBolt(), "ForegripBolt() is undefined. Unknown FOREGRIP_BOLT?");

function RecoilPlateBolt() = BoltSpec(RECOIL_PLATE_BOLT);
assert(RecoilPlateBolt(), "RecoilPlateBolt() is undefined. Unknown RECOIL_PLATE_BOLT?");

// Shorthand: Measurements
function BarrelRadius(clearance=0)
    = (BARREL_DIAMETER+clearance)/2;

function BarrelDiameter(clearance=0)
    = (BARREL_DIAMETER+clearance);
    
function CylinderDiameter() = CYLINDER_DIAMETER;
function CylinderRadius() = CylinderDiameter()/2;

// Calculated: Lengths
function ForendLength() = FrameExtension(length=FrameBoltLength())
                        - ReceiverFrontLength()
                        - NutHexHeight(FrameBolt());

// Calculated: Positions
function BarrelMinX() = CylinderGap()+ChamberLength()+ShellRimLength();
function ForendMinX() = BarrelMinX();
function ForendMaxX() = ForendLength();
function ForegripMinX() = ForendMaxX()+ForegripGap()+ActionRodTravel()+1.5;

function SpindleTogglePinOffset() = 0.5;
function SpindleTogglePinX() = ForendMaxX()-SpindleTogglePinOffset();
function SpindleTogglePinZ() = CylinderZ()-0.3215/2;

function SpindlePinMinX() = ForendMinX()+BlastPlateThickness()+0.375;
function SpindlePinTravel() = RecoilPlateThickness();
function SpindlePinMaxX() = ForendMinX()+BlastPlateThickness()+0.375+SpindlePinTravel();
function SpindleLinkagePinOffset() = 0.5;
function SpindleLinkagePinX() = SpindleTogglePinX()-Revolver_ForendSpindleTogglePinRadius()-SpindleLinkagePinOffset();
  

function Revolver_BarrelSupportLength() = ForendMaxX()-ForendMinX();
echo("Barrel Support Length: ", Revolver_BarrelSupportLength());


// Distance between the toggle and spindle pins
hypotenuseExtended = pyth_A_B(abs(SpindleTogglePinZ()-CylinderZ()),
              SpindleTogglePinX()-SpindlePinMinX());
hypotenuseRetracted = pyth_A_B(abs(SpindleTogglePinZ()-CylinderZ()),
              SpindleTogglePinX()-SpindlePinMaxX());
hypotenuseDiff = hypotenuseExtended-hypotenuseRetracted;

echo("Spindle/Toggle Pin Hypotenuse: ",
     hypotenuseRetracted, hypotenuseExtended, hypotenuseDiff);

hypPins = pyth_A_B(abs(SpindleTogglePinZ()-CylinderZ()),
              SpindleTogglePinX()-SpindlePinMinX());
              
    
animateLock = (SubAnimate(ANIMATION_STEP_UNLOCK, start=0, end=1)
            - SubAnimate(ANIMATION_STEP_LOCK, start=0, end=1));

//************
//* Vitamins *
//************
module Revolver_Barrel(barrelLength=BarrelLength(), clearance=BARREL_CLEARANCE, cutter=false, alpha=1, debug=false) {

  clear = (cutter ? clearance : 0);
  clear2 = clear*2;

  color("Silver", alpha) DebugHalf(enabled=debug) RenderIf(!cutter)
  translate([(cutter?0:BarrelMinX()),0,0])
  rotate([0,90,0])
  difference() {
    cylinder(r=BarrelRadius()+clear,
             h=barrelLength+(cutter?ChamberLength():0),
             $fn=Resolution(20,50));
    
    if (!cutter)
    cylinder(r=CHAMBER_ID/2,
             h=barrelLength,
             $fn=Resolution(20,50));
  }
}

module Revolver_CylinderSpindle(template=false, cutter=false, clearance=0.01) {
  clear = cutter ? clearance : 0;
  clear2 = clear*2;

  color("Silver") RenderIf(!cutter)
  translate([-ReceiverFrontLength()-ManifoldGap(),0,CylinderZ()])
  rotate([0,90,0])
  Rod((template ? Spec_RodTemplate() : CylinderRod()),
      length=ForendMaxX()-ForendMinX()-1.5+(cutter?BlastPlateThickness()+0.5:0)+ManifoldGap(3), 
      clearance=cutter?RodClearanceSnug():undef);
}


module Revolver_ForendSpindle(template=false, cutter=false, clearance=0.01) {
  clear = cutter ? clearance : 0;
  clear2 = clear*2;

  color("Silver") RenderIf(!cutter)
  translate([ForendMinX()-BlastPlateThickness()-ManifoldGap(),0,CylinderZ()])
  rotate([0,90,0])
  Rod((template ? Spec_RodTemplate() : CylinderRod()),
      length=ForendMaxX()-ForendMinX()-1.5+(cutter?BlastPlateThickness()+0.5:0)+ManifoldGap(3), 
      clearance=cutter?RodClearanceSnug():undef);
}

module Revolver_ForendSpindlePin(cutter=false, teardrop=false, clearance=Revolver_ForendSpindlePinClearance()) {
  clear = cutter ? clearance : 0;
  
  color("Silver") render()
  translate([SpindlePinMinX(),0,CylinderZ()])
  rotate([90,0,0])
  linear_extrude(height=Revolver_ForendSpindlePinLength(), center=true)
  rotate(180)
  Teardrop(r=Revolver_ForendSpindlePinRadius()+clear, enabled=teardrop);
}
module Revolver_ForendSpindleLinkagePin(cutter=false, teardrop=false, clearance=Revolver_ForendSpindleLinkagePinClearance()) {
  clear = cutter ? clearance : 0;
  
  color("Silver") RenderIf(cutter==false)
  translate([SpindleLinkagePinX(),0,CylinderZ()])
  rotate([90,0,0])
  linear_extrude(height=Revolver_ForendSpindleTogglePinLength(), center=true)
  rotate(180)
  Teardrop(r=Revolver_ForendSpindleTogglePinRadius()+clear, enabled=teardrop);
}

module Revolver_ForendSpindleTogglePin(cutter=false, teardrop=false, clearance=Revolver_ForendSpindleTogglePinClearance()) {
  clear = cutter ? clearance : 0;
  
  color("Silver") RenderIf(cutter==false)
  translate([SpindleTogglePinX(),0,SpindleTogglePinZ()])
  rotate([90,0,0])
  linear_extrude(height=Revolver_ForendSpindleTogglePinLength(), center=true)
  rotate(180)
  Teardrop(r=Revolver_ForendSpindleTogglePinRadius()+clear, enabled=teardrop);
}

module Revolver_PumpLockRod(cutter=false, clearance=0.005) {
  clear = cutter ? clearance : 0;
  clear2 = clear * 2;
  
  length = 2;
  width = 0.25;
  
  color("Silver") RenderIf(!cutter)
  translate([ForendMaxX()-1,-(width/2)-clear,-BarrelRadius()-width-clear])
  cube([length, width+clear2, width+clear2]);
}
module Revolver_BlastPlate(clearance=0.01, cutter=false, debug=false) {
  clear = cutter ? clearance : 0;
  clear2 = clear*2;

  color("LightSteelBlue")
  RenderIf(!cutter) DebugHalf(enabled=debug)
  difference() {
    translate([BarrelMinX(), // Don't *really* need to clear here
               -(BlastPlateWidth()/2)-clear,
               ActionRodZ()-0.125])
    mirror([0,0,1])
    cube([BlastPlateThickness(),
          BlastPlateWidth()+clear2,
          2.25]);

    if (!cutter)
    Revolver_Barrel(cutter=true);
    SimpleActionRod(cutter=true);
    Revolver_ForendSpindle(cutter=true);
  }
}

module Revolver_Shield(cutter=false) {
  translate([ForendMinX()+0.25,0,CylinderZ()-0.01])
  rotate([0,-90,0])
  linear_extrude(height=0.5)
  rotate(90)
  semidonut(minor=CylinderDiameter()-0.25, major=CylinderDiameter(), angle=180, $fn=100);
}
module Revolver_RecoilPlateBolts(bolt=RecoilPlateBolt(), boltLength=FiringPinHousingLength()+0.5, template=false, cutter=false, clearance=RECOIL_PLATE_BOLT_CLEARANCE) {
  bolt     = template ? BoltSpec("Template") : bolt;
  boltHead = template ? "none"               : "flat";
  
  color("Silver")
  RenderIf(!cutter) {
  
    // Top
    translate([0.5+ManifoldGap(),0,0.5])
    rotate([0,-90,0])
    Bolt(bolt=bolt, length=0.5+ManifoldGap(2),
          head=boltHead,
          clearance=cutter?clearance:0);

    // Bottom
    color("Silver")
    translate([0.5+ManifoldGap(),0,CylinderZ()-0.5])
    rotate([0,-90,0])
    Bolt(bolt=bolt,
         length=0.5+ManifoldGap(2),
         head=boltHead,
         clearance=cutter?clearance:0);
  }
}
module Revolver_RecoilPlate(template=false, cutter=false, debug=_CUTAWAY_RECOIL_PLATE) {
  color("LightSteelBlue")
  RenderIf(!cutter) DebugHalf(enabled=debug)
  difference() {
    translate([ReceiverFrontLength()-RecoilPlateThickness()+(cutter?ManifoldGap():0),
               -RecoilPlateWidth()/2,
               FrameTopZ()])
    mirror([0,0,1])
    cube([RecoilPlateThickness()+(cutter?ManifoldGap():0),
          RecoilPlateWidth(),
          3]);

    if (!cutter) {
      FiringPin(cutter=true, radius=(template?1/32/2:FiringPinRadius()));
      Revolver_CylinderSpindle(cutter=true, template=template);
      Revolver_RecoilPlateBolts(cutter=true, template=template);
      SimpleActionRod(cutter=true);
    }
  }
}

//*****************
//* Printed Parts *
//*****************
module Revolver_ReceiverFront(debug=_CUTAWAY_RECEIVER_FRONT, alpha=_ALPHA_RECEIVER_FRONT) {
  length = abs(RecoilSpreaderThickness());
  
  color("Chocolate", alpha)
  render() DebugHalf(enabled=debug)
  difference() {
    union() {
      FrameSupport(length=length,
                   extraBottom=FrameBoltZ()+abs(CylinderZ()));
      
      // Cover the back of the cylinder to prevent blowback
      translate([0,0,CylinderZ()])
      rotate([0,90,0])
      ChamferedCylinder(r1=(BarrelRadius()*3)+(CR()*2)+0.125, r2=CR(),
                        h=length-ManifoldGap(), $fn=Resolution(80, 200));
    }
    
    FrameBolts(cutter=true);
    
    CouplingBolts(extension=ReceiverFrontLength(), boltHead="flat", cutter=true);

    Revolver_RecoilPlate(cutter=true);
    
    FiringPin(cutter=true);
    
    Revolver_RecoilPlateBolts(cutter=true);
    
    SimpleActionRod(cutter=true);

    Revolver_ForendSpindle(cutter=true);
  }
}

module Revolver_ReceiverFront_print() {
  rotate([0,-90,0])
  Revolver_ReceiverFront();
}

module Revolver_BarrelSupport(doRender=true, debug=false, alpha=_ALPHA_FOREND, $fn=Resolution(30,100)) {
  extraBottom=0;
  
  color("DimGrey", alpha) 
  RenderIf(doRender) {
    
    fontSize = 0.375;
    
    // Right-side text
    translate([ForendMaxX()-0.375,-FrameWidth()/2,FrameBoltZ()-(fontSize/2)])
    rotate([90,0,0])
    linear_extrude(height=LogoTextDepth(), center=true)
    text(BRANDING_MODEL_NAME, size=fontSize, font="Impact", halign="right");

    // Left-side text
    translate([ForendMaxX()-0.375,FrameWidth()/2,FrameBoltZ()-(fontSize/2)])
    rotate([90,0,0])
    linear_extrude(height=LogoTextDepth(), center=true)
    mirror([1,0])
    text(BRANDING_MODEL_NAME, size=fontSize, font="Impact", halign="left");
  }
  
  color("Tan", alpha)
  RenderIf(doRender) DebugHalf(enabled=debug)
  difference() {
    union() {
      
      // Frame support
      difference() {
        translate([ForendMinX(),0,0])
        FrameSupport(length=Revolver_BarrelSupportLength(),
                     extraBottom=extraBottom);

        *hull()
        Revolver_Shield(cutter=true);
      }

      // Around the barrel
      difference() {
        hull() {
          translate([ForendMinX()+BlastPlateThickness(),0,0])
          rotate([0,90,0])
          ChamferedCylinder(r1=BarrelRadius()+WallBarrel(), r2=CR(),
                   h=Revolver_BarrelSupportLength()-BlastPlateThickness(),
                              teardropTop=true);
          
          translate([ForendMinX()+BlastPlateThickness(), -(BarrelRadius()+WallBarrel()), 0])
          ChamferedCube([Revolver_BarrelSupportLength()-BlastPlateThickness(),
                         (BarrelRadius()+WallBarrel())*2,
                         FrameBoltZ()], r=CR());
        }
      }

      // Around the spindle
      hull() {
        translate([ForendMinX()+BlastPlateThickness(), -(0.6875/2), CylinderZ()+SpindleRadius()])
        ChamferedCube([Revolver_BarrelSupportLength()-BlastPlateThickness()-(Revolver_ForendSpindleLinkagePinRadius()*2)-1,
                       0.6875,
                       1], r=CR(), teardropFlip=[false,true,true]);
        translate([ForendMinX()+BlastPlateThickness(), -(0.6875/2), CylinderZ()-(SpindleRadius()+WallSpindle())])
        ChamferedCube([Revolver_BarrelSupportLength()-BlastPlateThickness()-1-(Revolver_ForendSpindleLinkagePinRadius()*2)-(SpindleRadius()+WallSpindle()+abs(SpindleTogglePinZ()-CylinderZ())),
                       0.6875,
                       1], r=CR(), teardropFlip=[false,true,true]);
      }
      
      // Spindle toggle pivot pin support
      translate([ForendMaxX()-1, -(0.6875/2), CylinderZ()-(SpindleRadius()+WallSpindle())])
      ChamferedCube([1,
                     0.6875,
                     1], r=CR(), teardropFlip=[false,true,true]);
      
      // Fillet barrel to the frame
      for (M = [0,1]) mirror([0,M,0])
      translate([ForendMinX()+BlastPlateThickness()+CR(),
                 BarrelRadius()+WallBarrel()-ManifoldGap(2),
                 FrameBottomZ()-extraBottom+ManifoldGap()])
      rotate([0,90,0])
      rotate(-90)
      Fillet(r=WallFrameBolt(), h=Revolver_BarrelSupportLength()-BlastPlateThickness()-(CR()*2),
                     taperEnds=true);
    }
    
    // Cutout for a picatinny rail insert
    translate([-ManifoldGap(), -UnitsMetric(15.6/2), FrameTopZ()-0.0625])
    cube([FrameExtension()+ManifoldGap(2), UnitsMetric(15.6), 0.25]);
    
    // Blast plate fillet weld clearance
    translate([ForendMinX()+BlastPlateThickness(), 0, 0])
    rotate([0,90,0])
    HoleChamfer(r1=BarrelRadius(), r2=0.25, teardrop=true);
    
    // Handle pivot clearance
    rotate([90,0,0])
    linear_extrude(height=0.3125+0.02, center=true)
    translate([SpindleTogglePinX(),SpindleTogglePinZ()])
    mirror([1,0])
    semicircle(od=(pyth_A_B(abs(SpindleTogglePinZ()-CylinderZ()),
                           SpindleTogglePinX()-SpindleLinkagePinX())+0.02+0.1875)*2,
               angle=60);
    
    // Linkage pin pivot path
    *rotate([90,0,0])
    linear_extrude(height=1, center=true)
    translate([SpindleTogglePinX(),SpindleTogglePinZ()])
    mirror([1,0])
    semidonut(major=(pyth_A_B(abs(SpindleTogglePinZ()-CylinderZ()),
                           SpindleTogglePinX()-SpindleLinkagePinX())
                           +(Revolver_ForendSpindleLinkagePinRadius()
                            + Revolver_ForendSpindleLinkagePinClearance()))*2,
              minor=(pyth_A_B(abs(SpindleTogglePinZ()-CylinderZ()),
                           SpindleTogglePinX()-SpindleLinkagePinX())
                           -(Revolver_ForendSpindleLinkagePinRadius()
                            + Revolver_ForendSpindleLinkagePinClearance()))*2,
               angle=25);
    
    FrameBolts(cutter=true);

    SimpleActionRod(cutter=true);
    
    //Revolver_PumpLockRod(cutter=true);

    Revolver_Barrel(cutter=true);
    Revolver_BlastPlate(cutter=true);
    
    Revolver_ForendSpindle(cutter=true);
    
    hull() {
      Revolver_ForendSpindlePin(cutter=true, teardrop=true);
      
      translate([SpindlePinTravel(),0,0])
      Revolver_ForendSpindlePin(cutter=true);
    }
    
    Revolver_ForendSpindleTogglePin(cutter=true, teardrop=true);
    
    for (P = [0,1])
    Revolver_ForendSpindleToggleHandle(pivot=P, cutter=true, teardrop=true);
  }
}

module Revolver_BarrelSupport_print() {
  rotate([0,90,0]) translate([-ForendMaxX(),0,0])
  render()
  Revolver_BarrelSupport(doRender=false);
}
module Revolver_FrameSpacer(length=ForendMinX(), debug=false, alpha=_ALPHA_FOREND) {
  extraBottom=0;
  
  color("Tan", alpha)
  render() DebugHalf(enabled=debug)
  difference() {
    hull() {
      
      // Curvy section to accept and index the cylinder
      FrameSupport(length=length);
      
      // Curvy section to accept and index the cylinder
      FrameSupport(length=1,
                   extraBottom=0.5);
    }

    // Picatinny rail cutout
    translate([-ManifoldGap(), -UnitsMetric(15.6/2), FrameTopZ()-0.0625])
    cube([length+ManifoldGap(2), UnitsMetric(15.6), 0.25]);
    
    // Gas Vent
    translate([BarrelMinX()-0.375,-(1.5/2),FrameBottomZ()-extraBottom])
    ChamferedSquareHole(sides=[1, 1.5], center=false,
                        length=FrameTopZ()-FrameBottomZ()+extraBottom,
                        corners=false,
                        chamferRadius=0.5);

    FrameBolts(cutter=true);
    
    SimpleActionRod(cutter=true);
    
    // Cylinder Cutout
    translate([0,0,CylinderZ()])
    rotate([0,90,0])
    cylinder(r=CylinderRadius()+CYLINDER_CLEARANCE, h=length, $fn=120);
  }
}

module Revolver_FrameSpacer_print() {
  rotate([0,-90,0])
  translate([0,0,-FrameBoltZ()])
  Revolver_FrameSpacer();
}




        
module Revolver_ForendSpindleToggleLinkage(pivot=0, cutter=false, clearance=0.01) {
  clear = cutter ? clearance : 0;
  clear2 = clear*2;
    
  Pivot(pivotX=SpindlePinMinX(),
        pivotZ=CylinderZ(),
        angle=24, factor=pivot) {

    color("Chocolate") render()
    difference() {
      union() {        
        translate([0,0.5,0])
        rotate([90,0,0])
        linear_extrude(height=0.125)
        difference() {
          hull() {
            translate([SpindleLinkagePinX(),CylinderZ()])
            rotate(180)
            Teardrop(r=0.1875+clear, enabled=false);
            
            translate([SpindlePinMinX(),CylinderZ()])
            rotate(180)
            Teardrop(r=0.1875+clear, enabled=false);
          }
          
          // Linkage Pin
          translate([SpindleLinkagePinX(),CylinderZ()])
          rotate(180)
          Teardrop(r=Revolver_ForendSpindleLinkagePinRadius()+Revolver_ForendSpindleLinkagePinClearance(),
                   enabled=false);
        }
        
      }
      
      Revolver_ForendSpindlePin(cutter=true);
    }
    
    children();
  }
}
module Revolver_ForendSpindleToggleLinkage_print() {
  rotate([-90,0,0])
  translate([-SpindleLinkagePinX(),-0.5,-CylinderZ()])
  Revolver_ForendSpindleToggleLinkage();
}
module Revolver_ForendSpindleToggleHandle(pivot=0, cutter=false, clearance=0.01, teardrop=false) {
  clear = cutter ? clearance : 0;
  clear2 = clear*2;
  
  Pivot(pivotX=SpindleTogglePinX(), pivotZ=SpindleTogglePinZ(),
        angle=-60,factor=pivot) {
    color("Brown") render()
    difference() {
      union() {
        
        // Connection to linkage
        rotate([90,0,0])
        linear_extrude(height=0.3125+clear2, center=true)
        hull() {
          translate([SpindleTogglePinX(),SpindleTogglePinZ()])
          circle(r=0.1875+clear);
          
          translate([SpindleLinkagePinX(),CylinderZ()])
          rotate(180)
          Teardrop(r=0.1875+clear, enabled=teardrop);
          
          // Connect to bottom section
          translate([SpindleTogglePinX()-0.25,CylinderZ()-0.5])
          circle(r=0.125+clear);
          
          translate([SpindleTogglePinX()-0.625,CylinderZ()-0.5])
          circle(r=0.125+clear);
        }
        
        // Bottom section, handle
        rotate([90,0,0])
        linear_extrude(height=0.3125, center=true)
        hull() {
          translate([SpindleTogglePinX()-1.75,CylinderZ()-0.5])
          rotate(180)
          circle(r=0.125+clear);
          
          translate([SpindleTogglePinX()-0.25,CylinderZ()-0.5])
          rotate(180)
          circle(r=0.125+clear);
        }
      }
      
      Revolver_ForendSpindlePin(cutter=true);
      Revolver_ForendSpindleTogglePin(cutter=true);
          
      // Linkage Pin
      Revolver_ForendSpindleLinkagePin(cutter=true);
    }
    
    children();
  }
}
module Revolver_ForendSpindleToggleHandle_print() {
  rotate([90,0,0])
  translate([-SpindlePinMinX(),(5/16/2),-CylinderZ()])
  Revolver_ForendSpindleToggleHandle();
}

module Revolver_Cylinder(supports=true, chamberBolts=false, debug=_CUTAWAY_CYLINDER, alpha=_ALPHA_CYLINDER, render_cylinder=true) {
  OffsetZigZagRevolver(
      diameter=CYLINDER_DIAMETER,
      height=CYLINDER_LENGTH,
      centerOffset=abs(CylinderZ()),
      spindleRadius=RodRadius(CylinderRod())+0.005,
      chamberRadius=BarrelRadius(),
      chamberClearance=BARREL_CLEARANCE,
      chamberInnerRadius=CHAMBER_ID/2,
      extraBottom=0,
      extraTop=0,
      supportsBottom=false, supportsTop=supports,
      chamberBolts=chamberBolts,
      chambers=true, chamberLength=ChamberLength(),
      debug=debug, alpha=alpha,
      render_cylinder=render_cylinder);
}


module Revolver_CylinderCore_print() {
  render()
  intersection() {
  
    translate([0,0, CYLINDER_LENGTH])
    rotate([0,180,0])
    Revolver_Cylinder(render_cylinder=false);
    
    cylinder(r=CYLINDER_OFFSET-(BARREL_DIAMETER*0.33), h=0.5, $fn=100);
  }
}

module Revolver_CylinderShell_print() {
  render()
  difference() {
  
    translate([0,0, CYLINDER_LENGTH])
    rotate([0,180,0])
    Revolver_Cylinder(render_cylinder=false);
    
    cylinder(r=CYLINDER_OFFSET+0.0625, h=CYLINDER_LENGTH+ManifoldGap(), $fn=100);
  }
}

module Foregrip(length=2) {
  render()
  difference() {
    union() {      
      translate([ForegripMinX(),0,0])
      rotate([0,90,0])
      ChamferedCylinder(r1=BarrelRadius()+WallBarrel(), r2=1/16, h=length);
      
      // Grip block
      translate([ForegripMinX(),-1/2,0])
      rotate([0,90,0])
      ChamferedCube([abs(CylinderZ())+0.25, 1, length], r=1/16);
      
      // Action Rod Support Block
      translate([ForegripMinX(),-0.75/2,0])
      ChamferedCube([1, 0.75, 1.125], r=1/16);
    }
    
    SimpleActionRod(cutter=true);
    Revolver_Barrel(cutter=true);
    
    // Foregrip bolt
    translate([ForegripMinX()+0.5,0,0])
    cylinder(r=1/8/2, h=2);
  }
}
module Foregrip_print() {
  rotate([0,-90,0])
  translate([-ForegripMinX(),0,0])
  Foregrip();
}


//**************
//* Assemblies *
//**************
module RevolverForendAssembly(pipeAlpha=1, debug=false) {
  if (_SHOW_BARREL) {
    Revolver_Barrel(debug=debug);
    Revolver_BlastPlate();
  }
  
  Revolver_PumpLockRod();

  if (_SHOW_FRAME_SPACER)
  Revolver_FrameSpacer(debug=_CUTAWAY_FOREND, alpha=_ALPHA_FOREND);
  
  if (_SHOW_BARREL_SUPPORT)
  Revolver_BarrelSupport(debug=_CUTAWAY_BARREL_SUPPORT, alpha=_ALPHA_FOREND);
  
  if (_SHOW_SPINDLE) {
    Revolver_ForendSpindleTogglePin();
    
    translate([SpindlePinTravel()*animateLock,0,0]) {
      Revolver_ForendSpindle();
      Revolver_ForendSpindlePin();
      
      for (M = [0,1]) mirror([0,M,0])
      Revolver_ForendSpindleToggleLinkage(pivot=animateLock);
    }
    
    Revolver_ForendSpindleToggleHandle(pivot=animateLock)
        Revolver_ForendSpindleLinkagePin();;
  }

  if (_SHOW_RECEIVER_FRONT)
  translate([-0.5,0,0])
  Revolver_ReceiverFront();

  animateCylinderRotation = SubAnimate(ANIMATION_STEP_CHARGER_RESET, start=0.25, end=0.8)
                          + SubAnimate(ANIMATION_STEP_CHARGE, start=0.4, end=0.98);
  animateCylinderRemoval = SubAnimate(ANIMATION_STEP_UNLOAD, start=0, end=1)
                         - SubAnimate(ANIMATION_STEP_LOAD, start=0, end=1);
  if (_SHOW_CYLINDER)
  translate([ShellRimLength(),0,CylinderZ()-(3.5*animateCylinderRemoval)])
  rotate([0,90,0])
  rotate(-360/6/2*animateCylinderRotation)
  rotate(-360/6/2*animateCylinderRotation)
  Revolver_Cylinder(supports=false);
  
  if (_SHOW_SHIELD)
  Revolver_Shield();
}

module RevolverAssembly(stock=true) {
  
  translate([-ReceiverFrontLength(),0,0]) {
    
    if (_SHOW_LOWER_LUGS)
    LowerLugs();

    if (_SHOW_LOWER)
    translate([-LowerMaxX(),0,LowerOffsetZ()+0.0625])
    Lower(showTrigger=true,
          showReceiverLugBolts=true, showGuardBolt=true, showHandleBolts=true,
          searLength=SearLength()+abs(LowerOffsetZ())+SearTravel()-(0.25/2));
    
    if (_SHOW_RECEIVER) {
      ReceiverRods();
      
      Receiver_LargeFrameAssembly(debug=_CUTAWAY_RECEIVER);
      ReceiverBackSegment();
    }

    if (_SHOW_STOCK) {
      StockAssembly();
    }

    if (_SHOW_RECOIL_PLATE) {
      Revolver_RecoilPlate();
      Revolver_RecoilPlateBolts();
    }

    if (_SHOW_FCG)
    SimpleFireControlAssembly() {
  
      if (_SHOW_PUMP)
      translate([ForegripMinX()+0.5,0,0])
      rotate([0,90,0])
      color("Tan") render()
      PumpGrip();
      //Foregrip();
    
      // Actuator pin
      *translate([0.125+ReceiverFrontLength()+ActionRodTravel(),0,ActionRodZ()])
      mirror([0,0,1])
      cylinder(r=0.125, h=0.15+0.125);
      
    
      // Forward Actuator Pin
      *translate([0.25+ForendMaxX(),0,ActionRodZ()])
      rotate([-90,0,0])
      cylinder(r=0.125, h=0.15+0.125+3);
    }
  }

  RevolverForendAssembly(debug=false);
}

if (_RENDER == "Revolver Assembly")
RevolverAssembly();

//**********
//* Prints *
//**********
scale(25.4) {
  
  if (_RENDER == "Receiver_LargeFrame")
  Receiver_LargeFrame_print();
  
  if (_RENDER == "Revolver_FrameBack")
  FrameBack_print();

  if (_RENDER == "Revolver_RecieverFront")
  Revolver_ReceiverFront_print();
  
  if (_RENDER == "Revolver_ReceiverBack")
  ReceiverBackSegment_print();
  
  if (_RENDER == "Revolver_BarrelSupport")
  Revolver_BarrelSupport_print();

  if (_RENDER == "Revolver_ForendSpindleToggleLinkage")
  Revolver_ForendSpindleToggleLinkage_print();

  if (_RENDER == "Revolver_ForendSpindleToggleHandle")
  Revolver_ForendSpindleToggleHandle_print();
  
  if (_RENDER == "Revolver_FrameSpacer")
  Revolver_FrameSpacer_print();
  
  if (_RENDER == "Foregrip")
  Foregrip_print();
  
  if (_RENDER == "RecoilPlate_Template")
  projection()
  rotate([0,90,0])
  Revolver_RecoilPlate(template=true);
  
  if (_RENDER == "Revolver_CylinderCore_Projection")
  projection(cut=true)
  Revolver_CylinderCore_print();
  
  if (_RENDER == "Revolver_CylinderCore")
  Revolver_CylinderCore_print();
  
  if (_RENDER == "Revolver_CylinderShell")
  Revolver_CylinderShell_print();
}
