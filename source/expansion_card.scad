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
front_thickness = 1.5;
rear_thickness = 1.0;
bottom_thickness = 1.0;
side_thickness = 1.5;

// USB-C plug dimensions
usb_c_r = 1.315;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = 2.2;

// To top of rail
rail_h = 4.25;

// Rotate into a printable orientation
rotate([-90, 0, 0]) translate([0, -base[1], 0]) expansion_card_base(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h, open_end=true, make_printable=true);
