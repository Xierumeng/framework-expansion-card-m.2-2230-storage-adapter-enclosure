include <anti_z_fighting.scad>

use <rail.scad>
use <usb_c_cutout.scad>

// A basic, printable Expansion Card enclosure
//  open_end - A boolean to make the end of the card that is exposed when inserted open
//  make_printable - Adds ribs to improve printability
module expansion_card_base(base, front_thickness, bottom_thickness, side_thickness, rail_h, usb_c_r, usb_c_w, usb_c_h, open_end, make_printable) {
    // Hollowing of the inside
    inner = [base[0] - side_thickness * 2, base[1] - front_thickness * 2, base[2] - bottom_thickness + anti_z_fighting_value];

    difference() {
        cube(base);

        difference() {
            // The main hollow
            translate([side_thickness, open_end ? -anti_z_fighting_value : front_thickness, bottom_thickness])
                cube([inner[0], open_end ? inner[1] + front_thickness + anti_z_fighting_value : inner[1], inner[2] + anti_z_fighting_value]);

            // Extra wall thickness where the latch cutouts are
            notch = 1.0;
            notch_offset = 1.5;
            notch_l = 4.5 - front_thickness;
            notch_h = 5.3 - bottom_thickness;

            assert(side_thickness >= notch_offset, "There is a gap if the side thickness is smaller than the notch offset!")

            translate([notch_offset, inner[1] + front_thickness - notch_l, bottom_thickness + notch_h / 2])
                rotate([0, 0, -90])
                    rotate([0, 90, 0])
                        __rib(notch_h, notch);

            translate([notch_offset, inner[1] + front_thickness - notch_l, bottom_thickness])
                cube([notch, notch_l, notch_h]);

            translate([base[0] - notch_offset, inner[1] + front_thickness - notch_l, bottom_thickness + notch_h / 2])
                rotate([0, 0, 180])
                    rotate([0, 90, 0])
                        __rib(notch_h, notch);

            translate([base[0] - notch_offset - notch, inner[1] + front_thickness - notch_l, bottom_thickness])
                cube([notch, notch_l, notch_h]);
        }

        // The USB-C plug cutout
        translate([base[0] / 2, base[1], usb_c_r + usb_c_h])
            usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, front_thickness, !open_end);

        // The sliding rails
        translate([0, base[1], rail_h])
            rail(base, 0, make_printable);

        translate([base[0], base[1], rail_h])
            mirror([1, 0, 0])
                rail(base, side_thickness, make_printable);
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
