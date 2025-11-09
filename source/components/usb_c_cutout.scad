// The cutout for the USB-C plug
module usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, open_top) {
    // The plug is "pushed in" by an extra 0.6 to account for 3d printing tolerances
    translate([-usb_c_w / 2 + usb_c_r, 7 - 10 + 0.6, usb_c_r]) rotate([-90, 0, 0]) union() {
                translate([0, usb_c_r, 0]) cylinder(r=usb_c_r, h=10, $fn=64);
                translate([usb_c_w - usb_c_r * 2, usb_c_r, 0]) cylinder(r=usb_c_r, h=10, $fn=64);
                cube([usb_c_w - usb_c_r * 2, usb_c_r * 2, 10]);

                // Cutout for the pin side of the shell that expands out
                translate([0, usb_c_r, 0]) cylinder(r2=usb_c_r, r1=3.84 / 2, h=10 - 7.7, $fn=64);
                translate([usb_c_w - usb_c_r * 2, usb_c_r, 0]) cylinder(r2=usb_c_r, r1=3.84 / 2, h=10 - 7.7, $fn=64);
                translate([usb_c_w / 2 - usb_c_r, usb_c_r, 0]) scale([1.8, 1, 1]) rotate([0, 0, 45]) cylinder(r2=usb_c_r * sqrt(2), r1=3.84 / 2 * sqrt(2), h=10 - 7.7, $fn=4);

                // If the card drops in from the top rather than sliding in from the front,
                // cut out a slot for the USB-C plug to drop into.
                if (open_top) {
                    translate([-usb_c_r, -10 + usb_c_r, 0]) cube([usb_c_w, 10, 10]);
                }
            }
}
