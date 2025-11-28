include <anti_z_fighting.scad>

use <rail.scad>
use <usb_c_cutout.scad>

// A basic, printable Expansion Card enclosure
//  open_end - A boolean to make the end of the card that is exposed when inserted open
//  make_printable - Adds ribs to improve printability
module expansion_card_base(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h, length_extra, lid_hole_depth, open_end, make_printable) {
    difference() {
        union() {
    // Hollowing of the inside
    inner = [base[0] - side_thickness * 2, base[1] - front_thickness - rear_thickness, base[2] - bottom_thickness + anti_z_fighting_value];

    difference() {
        cube(base);

        difference() {
            // The main hollow
            translate([side_thickness, open_end ? -anti_z_fighting_value : rear_thickness, bottom_thickness])
                cube([inner[0], open_end ? inner[1] + rear_thickness + anti_z_fighting_value : inner[1], inner[2] + anti_z_fighting_value]);

            // Extra wall thickness where the latch cutouts are
            notch = 1.0;
            notch_offset = 1.5;
            notch_l = 4.5 - front_thickness;
            notch_h = base[2] - 1.5 - bottom_thickness;

            assert(side_thickness >= notch_offset, "There is a gap if the side thickness is smaller than the notch offset!")

            translate([notch_offset, inner[1] + rear_thickness - notch_l, bottom_thickness + notch_h / 2])
                rotate([0, 0, -90])
                    rotate([0, 90, 0])
                        __rib(notch_h, notch);

            translate([notch_offset, inner[1] + rear_thickness - notch_l, bottom_thickness])
                cube([notch, notch_l, notch_h]);

            translate([base[0] - notch_offset, inner[1] + rear_thickness - notch_l, bottom_thickness + notch_h / 2])
                rotate([0, 0, 180])
                    rotate([0, 90, 0])
                        __rib(notch_h, notch);

            translate([base[0] - notch_offset - notch, inner[1] + rear_thickness - notch_l, bottom_thickness])
                cube([notch, notch_l, notch_h]);
        }

        // The USB-C plug cutout
        translate([base[0] / 2, base[1], usb_c_r + usb_c_h])
            usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, front_thickness, false);

        // The sliding rails
        translate([0, base[1], rail_h])
            rail(base, rear_thickness, make_printable);

        translate([base[0], base[1], rail_h])
            mirror([1, 0, 0])
                rail(base, rear_thickness, make_printable);
    }

    // TODO: Clean this up
    // Front holders
    front_fill = [(base[0] - 9 - 1.0) / 2 - (side_thickness - anti_z_fighting_value), 11.53 - 6.8 - 0.25, base[2]];

    color("blue")
        translate([side_thickness - anti_z_fighting_value, base[1] - (11.53 - 6.8 - 0.25), 0])
            cube(front_fill);

    color("blue")
        translate([base[0] - (base[0] - 9 - 1.0) / 2, base[1] - (11.53 - 6.8 - 0.25), 0])
            cube(front_fill);

    // Rear holders
    rear_fill = [(base[0] - 13.5 - 1.0) / 2, rear_thickness + 17.93 - 0.25, base[2]];

    color("red")
        cube(rear_fill);

    color("red")
        translate([base[0] - (base[0] - 13.5 - 1.0) / 2, 0, 0])
            cube(rear_fill);

    // USB A support
    color("purple")
        cube([base[0], rear_thickness + 17.93 - 0.25, base[2] - (1.97 + 2.63 / 2 + 4.52 / 2 + 0.25)]);
        }

        // Lid holes
        lid_side_hole = [side_thickness / 3, length_extra - rear_thickness - 1.0, lid_hole_depth + anti_z_fighting_value];

        // Sides
        translate([side_thickness / 3, rear_thickness, base[2] - lid_hole_depth])
            cube(lid_side_hole);

        translate([base[0] - side_thickness * 2 / 3, rear_thickness, base[2] - lid_hole_depth])
            cube(lid_side_hole);

        // Rear
        lid_rear_hole = [base[0] - side_thickness * 2 / 3, rear_thickness / 3, lid_hole_depth + anti_z_fighting_value];

        translate([side_thickness / 3, rear_thickness / 3, base[2] - lid_hole_depth])
            cube(lid_rear_hole);
    }
}

// A simple 45 degree rib to improve printability
module __rib(thickness, height) {
    translate([-thickness / 2, 0, 0])
        difference() {
            cube([thickness, height, height]);

            translate([-thickness / 2, height, 0])
                rotate([45, 0, 0])
                    cube([thickness * 2, height * 2, height * 2]);
        }
}
