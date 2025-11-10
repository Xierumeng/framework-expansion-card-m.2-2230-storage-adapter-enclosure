use <../expansion_card_base.scad>

length_extra = 31.5 + 1.0;  // Rear thickness
bottom_extra = 1.71 + 1.0;  // Bottom thickness

// The basic dimensions of an Expansion Card
base = [30.0, 32.0 + length_extra, 6.8 + bottom_extra];

// Wall thicknesses
front_thickness = 1.5;
rear_thickness = 1.0;
bottom_thickness = 1.0;
side_thickness = 1.5;

// USB-C plug dimensions
usb_c_r = 1.315;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = bottom_extra + 2.2;

// To top of rail
rail_h = usb_c_h + 2.05;

expansion_card_base(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h, open_end=false, make_printable=true);
