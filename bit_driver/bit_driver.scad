// all units in mm

drive_bit_depth = 25;
drive_bit_major_diameter = 7.1;
insert_bit_depth = 20;
insert_bit_major_diameter = 7.1;
insert_bit_offset = 1;
insert_bit_count = 4;
wall_thickness = 1;

difference(){

    // positive space
    linear_extrude(height=drive_bit_depth + wall_thickness + insert_bit_count*(insert_bit_major_diameter+insert_bit_offset)) {
        square(size=[insert_bit_depth, drive_bit_major_diameter+2*wall_thickness], center=true);
    }

    // negative space
    union() {
        // cutout for drive bit
        linear_extrude(height=drive_bit_depth) {
            union() {
                // bit guide
                circle(d=drive_bit_major_diameter);
                // epoxy fill area
                square(size=[insert_bit_depth - 2*wall_thickness,drive_bit_major_diameter*0.5], center=true);
            }
        }

        // cutouts for insert bits
        translate([0,0,drive_bit_depth + wall_thickness]){
            rotate([0,270,0]){
                linear_extrude(height=insert_bit_depth, center=true) {
                    union() {
                        for (i=[0:insert_bit_count-1]){
                            translate([insert_bit_major_diameter / 2 + (insert_bit_major_diameter + insert_bit_offset)*i,0,0]){
                                circle(d=drive_bit_major_diameter);
                            }
                        }
                    }
                }
            }
        }
    }

}