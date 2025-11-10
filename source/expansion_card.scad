// Parametric Expansion Card
//  An OpenSCAD implementation of a basic enclosure of an Expansion Card for
//  use with Framework products like the Framework Laptop.
//
//  See https://frame.work for more information about Framework products and
//  additional documentation around Expansion Cards.

// Parametric Expansion Card © 2021 by Nirav Patel at Framework Computer LLC
// is licensed under Attribution 4.0 International. 
// To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/

use <components/expansion_card_base.scad>

// The basic dimensions of an Expansion Card
base = [30.0, 32.0, 6.8];

// Wall thicknesses
side_thickness = 1.5;

// USB-C plug dimensions
usb_c_r = 1.315;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = 2.2;

rail_h = 4.25; // to top of rail

// Incomplete implementation of a lid to use with this shell
module expansion_card_lid() {
    gap = 0.25;
    union() {
        translate([side_thickness + gap, side_thickness + gap, base[2] - side_thickness]) cube([base[0] - side_thickness * 2 - gap * 2, base[1] - side_thickness * 2 - gap * 2, side_thickness]);
        difference() {
            translate([base[0] / 2 - usb_c_w / 2 + gap, base[1] - side_thickness - gap, usb_c_r + usb_c_h]) cube([usb_c_w - gap * 2, side_thickness + gap, base[2] - (usb_c_r + usb_c_h)]);
            translate([base[0] / 2, base[1], usb_c_r + usb_c_h]) usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, side_thickness, false);
        }
    }
}

// Rotate into a printable orientation
rotate([-90, 0, 0]) translate([0, -base[1], 0]) expansion_card_base(base, side_thickness, rail_h, usb_c_r, usb_c_w, usb_c_h, open_end=true, make_printable=true);
