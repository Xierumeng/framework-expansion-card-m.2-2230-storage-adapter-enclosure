// Parametric Expansion Card
//  An OpenSCAD implementation of a basic enclosure of an Expansion Card for
//  use with Framework products like the Framework Laptop.
//
//  See https://frame.work for more information about Framework products and
//  additional documentation around Expansion Cards.

// Parametric Expansion Card © 2021 by Nirav Patel at Framework Computer LLC
// is licensed under Attribution 4.0 International. 
// To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/

use <clearances.scad>
use <components/expansion_card_base.scad>

length_extra = 32.0 + 3.0; // Rear thickness
bottom_extra = 1.71 + 1.0; // Bottom thickness

// The basic dimensions of an Expansion Card
base = [30.0, 32.0 + length_extra, 6.8 + bottom_extra];

// Wall thicknesses
front_thickness = 1.0;
rear_thickness = 3.0;
bottom_thickness = 1.0;
side_thickness = 3.0;

// Reference height from bottom
reference_height = bottom_extra + 2.2;

// USB-C plug dimensions
usb_c_r = 1.315 + 0.14;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = reference_height + 1.315 - usb_c_r;

// To top of rail
rail_h = reference_height + 2.05;

// Lid hole
lid_hole_depth = 5.0;

check_clearances(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h);

// Rotate into a printable orientation
rotate([-90, 0, 0]) translate([0, -base[1], 0]) expansion_card_base(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h, length_extra, lid_hole_depth, open_end=true, make_printable=true);
