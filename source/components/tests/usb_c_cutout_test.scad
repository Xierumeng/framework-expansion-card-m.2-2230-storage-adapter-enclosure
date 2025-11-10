use <../usb_c_cutout.scad>

// USB-C plug dimensions
usb_c_r = 1.315;
usb_c_w = 5.86 + usb_c_r * 2;
usb_c_h = 2.2;
front_thickness = 1.5;

usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, front_thickness, true);
