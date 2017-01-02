// Globals

motorDiameter = 16;
motorLength   = 40;

baseLength    = 180;
baseWidth     = 100;
baseThick     = 3;
ridgeThick    = 5;

droneColor    = [0, .75, 0, 1];
    
armLength     = 160;
armWidth      = 30;
armXOffset    = 20;
armYOffset    = 70;
armAngle      = 20;
armRidgeShort = 44;

legHeight     = 30;
// Run

main();

module main() {
        union() 
        {
    color(droneColor) {

            base();
            // Arms
            arm(armLength, armWidth, armXOffset, armYOffset, armAngle);
            arm(armLength, armWidth, armXOffset, -armYOffset, -armAngle);
            arm(armLength, armWidth, -armXOffset, armYOffset, 180 - armAngle);
            arm(armLength, armWidth, -armXOffset, -armYOffset, 180 + armAngle);

            leg(legHeight, baseWidth/2 - 120, baseLength/6);
            leg(legHeight, baseWidth/2 - 120, baseLength/3);
            leg(legHeight, baseWidth/2 - 120, -baseLength/6);
            leg(legHeight, baseWidth/2 - 120, -baseLength/3);

        }    
    }
}
//

// Code

module base() 
{
    
//    arm(armLength, armWidth, 0, 0, 0);
/**/
    union(){
        difference() {
            // Base
            cube(
                [baseWidth, baseLength, baseThick],
                center = true
            );

            // Leg hole
            translate([baseWidth/2 - 12, baseLength/2  - motorDiameter - 16, 0]){
                cylinder(motorLength, motorDiameter/4, motorDiameter/4, center = true);
            };

            // Leg hole
            translate([-baseWidth/2 + 12, baseLength/2 - motorDiameter - 16, 0]){
                cylinder(motorLength, motorDiameter/4, motorDiameter/4, center = true);
            };

            // Leg hole
            translate([baseWidth/2 - 12, -baseLength/2  + motorDiameter + 16, 0]){
                cylinder(motorLength, motorDiameter/4, motorDiameter/4, center = true);
            };
            
            // Leg hole
            translate([-baseWidth/2 + 12, -baseLength/2  + motorDiameter + 16, 0]){
                cylinder(motorLength, motorDiameter/4, motorDiameter/4, center = true);
            };
            
            // Cable Hole
            translate([0, baseLength/2 - 20, 0]){
                cylinder(motorLength, motorDiameter/2, motorDiameter/2, center = true);
            };

        }
        
        // Stiffeners 
        translate([0, baseLength/2 - 8, ridgeThick/2]) {
            cube([baseWidth, ridgeThick, ridgeThick], center = true);
        }
        translate([0, -baseLength/2 + 8, ridgeThick/2]) {
            cube([baseWidth, ridgeThick, ridgeThick], center = true);
        }

        translate([baseWidth/2-4, 0, ridgeThick/2]) {
            cube([ridgeThick, baseLength - 8, ridgeThick], center = true);
        }
        translate([-baseWidth/2+4, 0, ridgeThick/2]) {
            cube([ridgeThick, baseLength - 8, ridgeThick], center = true);
        }
            
    
    }
/**/
}

module leg(height, x, y) 
{
    translate([x, y, height/2]) {
        union() {
            cube([motorDiameter/1.5, motorDiameter/1.5, height], center = true);
            translate([0, 0, height - ridgeThick*3]) {
                cylinder(ridgeThick*2, motorDiameter/4, motorDiameter/4, center = true);
            }
        }
    }
}

module arm(len, wid, x, y, deg) 
{
    union() {
        translate([cos(deg)*len/2 + x, sin(deg)*len/2 + y, 0]) {
            rotate(deg) {
                union() {
                    
                    // Plate with hole
                    difference() {
                        cube(
                            [len, wid, baseThick],
                            center = true
                        );
                        translate([len/2 - motorDiameter, 0, 0]){
                            cylinder(motorLength, motorDiameter/2, motorDiameter/2, center = true);
                        };
                    }

                    
                    translate([-1.2*motorDiameter+2, 0, baseThick]) {
                        union() {
                            // Motor Support
                            translate([(len-motorDiameter)/2 - motorLength/2, 0, (motorLength*.75)/2-2]) {
                                difference() {
                                    cube ([motorLength, ridgeThick*2, motorLength*.75], center = true);
                                    translate([motorLength-motorDiameter*1.7, 0, -motorLength*.1]){
                                        rotate([90,0,0]) {
                                            cylinder(50, motorDiameter/4, motorDiameter/4, center = true);
                                        }
                                    };
                                    translate([motorLength-motorDiameter*1.7, 0, motorLength*.2]){
                                        rotate([90,0,0]) {
                                            cylinder(50, motorDiameter/4, motorDiameter/4, center = true);
                                        }
                                    };
                                    
                                }
                            }
                            // Plate Stiffner
                            cube ([len-motorDiameter*2 - armRidgeShort, ridgeThick, ridgeThick], center = true);
                        }
                    }

                }
            }
        }
    }
    
}






