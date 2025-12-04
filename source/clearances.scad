module check_clearances(base, front_thickness, rear_thickness, bottom_thickness, side_thickness, usb_c_r, usb_c_w, usb_c_h, rail_h) {
    echo(str("====== Check clearances ======"));

    usb_c_vertical_measurement = 2.41;
    usb_c_horizontal_measurement = 8.28;

    usb_c_vertical_clearance = usb_c_r * 2 - usb_c_vertical_measurement;
    echo(str("USB C hole vertical clearance: ", usb_c_vertical_clearance));
    assert(usb_c_vertical_clearance >= 0);

    usb_c_horizontal_clearance = usb_c_w - usb_c_horizontal_measurement;
    echo(str("USB C hole horizontal clearance: ", usb_c_horizontal_clearance));
    assert(usb_c_horizontal_clearance >= 0);

    board_width_measurement = 23.53;
    board_length_measurement = 11.53 - 6.8 + 40.81 + 17.93;
    board_height_measurement = 1.97 + 2.63 / 2 + 1.05 / 2 + 3.7;

    width_clearance = (base[0] - side_thickness * 2) - board_width_measurement;
    echo(str("Width clearance: ", width_clearance));
    assert(width_clearance >= 0);

    length_clearance_rear_only = (base[1] - rear_thickness) - board_length_measurement;
    echo(str("Length clearance (rear only): ", length_clearance_rear_only));
    assert(length_clearance_rear_only >= 0);

    bottom_clearance = (base[2] - bottom_thickness) - board_height_measurement;
    echo(str("Bottom clearance: ", bottom_clearance));
    assert(bottom_clearance >= 0);
}
