include <anti_z_fighting.scad>

use <rail.scad>
use <usb_c_cutout.scad>

// A basic, printable Expansion Card enclosure
//  open_end - A boolean to make the end of the card that is exposed when inserted open
//  make_printable - Adds ribs to improve printability
module expansion_card_base(base, side_wall, rail_h, usb_c_r, usb_c_w, usb_c_h, open_end, make_printable) {
    // Hollowing of the inside
    inner = [base[0] - side_wall * 2, base[1] - side_wall * 2, base[2] - side_wall + anti_z_fighting_value];

    difference() {
        cube(base);

        difference() {
            notch = 1.0;
            notch_l = 3.0;
            notch_h = 3.8;

            // The main hollow
            translate([side_wall, open_end ? -anti_z_fighting_value : side_wall, side_wall])
                cube([inner[0], open_end ? inner[1] + side_wall + anti_z_fighting_value : inner[1], inner[2] + anti_z_fighting_value]);

            // Extra wall thickness where the latch cutouts are
            translate([side_wall, inner[1] + side_wall - notch_l, side_wall + notch_h / 2])
                rotate([0, 0, -90])
                    rotate([0, 90, 0])
                        __rib(notch_h, notch);

            translate([side_wall, inner[1] + side_wall - notch_l, side_wall])
                cube([notch, notch_l, notch_h]);

            translate([inner[0] + side_wall, inner[1] + side_wall - notch_l, side_wall + notch_h / 2])
                rotate([0, 0, 180])
                    rotate([0, 90, 0])
                        __rib(notch_h, notch);

            translate([inner[0] + side_wall - notch, inner[1] + side_wall - notch_l, side_wall])
                cube([notch, notch_l, notch_h]);
        }

        // The USB-C plug cutout
        translate([base[0] / 2, base[1], usb_c_r + usb_c_h])
            usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, side_wall, !open_end);

        // The sliding rails
        translate([0, base[1], rail_h])
            rail(base, 0, make_printable);

        translate([base[0], base[1], rail_h])
            mirror([1, 0, 0])
                rail(base, side_wall, make_printable);
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
