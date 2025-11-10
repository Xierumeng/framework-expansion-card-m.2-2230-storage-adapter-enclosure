use <../expansion_card_base.scad>

// The basic dimensions of an Expansion Card
base = [30.0, 32.0, 6.8];

// Wall thicknesses
bottom_thickness = 1.0;
side_thickness = 1.5;

// USB-C plug dimensions
usb_c_r = 1.315;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = 2.2;

rail_h = 4.25; // to top of rail

expansion_card_base(base, bottom_thickness, side_thickness, rail_h, usb_c_r, usb_c_w, usb_c_h, open_end=true, make_printable=true);
