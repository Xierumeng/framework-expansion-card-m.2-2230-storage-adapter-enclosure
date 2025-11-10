// Parametric Expansion Card
//  An OpenSCAD implementation of a basic enclosure of an Expansion Card for
//  use with Framework products like the Framework Laptop.
//
//  See https://frame.work for more information about Framework products and
//  additional documentation around Expansion Cards.

// Parametric Expansion Card © 2021 by Nirav Patel at Framework Computer LLC
// is licensed under Attribution 4.0 International. 
// To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/

use <components/rail.scad>
use <components/usb_c_cutout.scad>

// The basic dimensions of an Expansion Card
base = [30.0, 32.0, 6.8];
// The default wall thickness
side_wall = 1.5;

// USB-C plug dimensions
usb_c_r = 1.315;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = 2.2;

rail_h = 4.25; // to top of rail

// A simple 45 degree rib to improve printability
module rib(thickness, height) {
    translate([-thickness / 2, 0, 0]) difference() {
            cube([thickness, height, height]);
            translate([-thickness / 2, height, 0]) rotate([45, 0, 0]) cube([thickness * 2, height * 2, height * 2]);
        }
}

// A simple cylinder cutout to fillet edges
module fillet(radius, length) {
    translate([length, 0, 0]) rotate([0, -90, 0]) difference() {
                cube([radius, radius, length]);
                translate([radius, radius, -1]) cylinder(h=length + 2, r=radius, $fn=64);
            }
}

// Incomplete implementation of a lid to use with this shell
module expansion_card_lid() {
    gap = 0.25;
    union() {
        translate([side_wall + gap, side_wall + gap, base[2] - side_wall]) cube([base[0] - side_wall * 2 - gap * 2, base[1] - side_wall * 2 - gap * 2, side_wall]);
        difference() {
            translate([base[0] / 2 - usb_c_w / 2 + gap, base[1] - side_wall - gap, usb_c_r + usb_c_h]) cube([usb_c_w - gap * 2, side_wall + gap, base[2] - (usb_c_r + usb_c_h)]);
            translate([base[0] / 2, base[1], usb_c_r + usb_c_h]) usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, side_wall, false);
        }
    }
}

// A basic, printable Expansion Card enclosure
//  open_end - A boolean to make the end of the card that is exposed when inserted open
//  make_printable - Adds ribs to improve printability
module expansion_card_base(open_end, make_printable) {
    // Hollowing of the inside
    extra = 0.1;
    inner = [base[0] - side_wall * 2, base[1] - side_wall * 2, base[2] - side_wall + extra];

    difference() {
        cube(base);

        difference() {
            notch = 1.0;
            notch_l = 3.0;
            notch_h = 3.8;
            // The main hollow
            translate([side_wall, open_end ? 0 : side_wall, side_wall]) cube([inner[0], open_end ? inner[1] + side_wall : inner[1], inner[2]]);
            // Extra wall thickness where the latch cutouts are
            translate([side_wall, inner[1] + side_wall - notch_l, side_wall + notch_h / 2]) rotate([0, 0, -90]) rotate([0, 90, 0]) rib(notch_h, notch);
            translate([side_wall, inner[1] + side_wall - notch_l, side_wall]) cube([notch, notch_l, notch_h]);
            translate([inner[0] + side_wall, inner[1] + side_wall - notch_l, side_wall + notch_h / 2]) rotate([0, 0, 180]) rotate([0, 90, 0]) rib(notch_h, notch);
            translate([inner[0] + side_wall - notch, inner[1] + side_wall - notch_l, side_wall]) cube([notch, notch_l, notch_h]);
        }

        // The rounded front edge to match the laptop
        edge_r = 0.8;
        fillet(edge_r, base[0]);

        // The USB-C plug cutout
        translate([base[0] / 2, base[1], usb_c_r + usb_c_h]) usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, side_wall, !open_end);

        // The sliding rails
        translate([0, base[1], rail_h])
            rail(base, 0, make_printable);

        translate([base[0], base[1], rail_h])
            mirror([1, 0, 0])
                rail(base, side_wall, make_printable);

        // Cut out the end of what is normally the aluminum cover
        ledge_cut = 0.6;
        ledge_cut_d = 3.2;
        ledge_fillet_r = 0.3;

        translate([0, base[1] - ledge_cut_d, 0]) cube([base[0], ledge_cut_d, ledge_cut]);
        // The fillet on that cover
        translate([base[0], base[1] - ledge_cut_d, 0]) rotate([0, 0, 180]) fillet(ledge_cut / 2, base[0]);
    }
}

// Rotate into a printable orientation
rotate([-90, 0, 0]) translate([0, -base[1], 0]) expansion_card_base(open_end=true, make_printable=true);
