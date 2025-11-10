// The cutout for the USB-C plug
module usb_c_cutout(usb_c_r, usb_c_w, usb_c_h, front_thickness, open_top) {
    length = 10 + front_thickness;

    // The plug is "pushed in" by an extra 0.6 to account for 3d printing tolerances
    translate([-usb_c_w / 2 + usb_c_r, 7 - length + 0.6, usb_c_r])
        rotate([-90, 0, 0])
            union() {
                translate([0, usb_c_r, 0])
                    cylinder(r=usb_c_r, h=length, $fn=64);

                translate([usb_c_w - usb_c_r * 2, usb_c_r, 0])
                    cylinder(r=usb_c_r, h=length, $fn=64);

                cube([usb_c_w - usb_c_r * 2, usb_c_r * 2, length]);

                // Cutout for the pin side of the shell that expands out
                lesser = 7.7;

                translate([0, usb_c_r, 0])
                    cylinder(r2=usb_c_r, r1=3.84 / 2, h=length - lesser, $fn=64);

                translate([usb_c_w - usb_c_r * 2, usb_c_r, 0])
                    cylinder(r2=usb_c_r, r1=3.84 / 2, h=length - lesser, $fn=64);

                translate([usb_c_w / 2 - usb_c_r, usb_c_r, 0])
                    scale([1.8, 1, 1])
                        rotate([0, 0, 45])
                            cylinder(r2=usb_c_r * sqrt(2), r1=3.84 / 2 * sqrt(2), h=length - lesser, $fn=4);

                // If the card drops in from the top rather than sliding in from the front,
                // cut out a slot for the USB-C plug to drop into.
                if (open_top) {
                    translate([-usb_c_r, -10 + usb_c_r, 0])
                        cube([usb_c_w, 10, length]);
                }
            }
}
