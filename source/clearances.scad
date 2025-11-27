module check_clearances(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h) {
    usb_c_vertical_measurement = 2.41;
    usb_c_horizontal_measurement = 8.28;

    usb_c_vertical_clearance = usb_c_r * 2 - usb_c_vertical_measurement;
    echo(str("USB C hole vertical clearance: ", usb_c_vertical_clearance));
    assert(usb_c_vertical_clearance >= 0);

    usb_c_horizontal_clearance = usb_c_w - usb_c_horizontal_measurement;
    echo(str("USB C hole horizontal clearance: ", usb_c_horizontal_clearance));
    assert(usb_c_horizontal_clearance >= 0);
}
