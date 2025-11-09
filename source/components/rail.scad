// The rail cutout in the sides of the card
module rail(base, side_wall, make_printable) {
    rail_depth = 0.81;
    rail_flat_h = 0.32;

    mirror([0, 1, 0]) {

        // The rail that holds the card
        bottom_angle = 43.54;
        difference() {
            union() {
                translate([rail_depth, 0, -rail_flat_h]) rotate([0, 180 + bottom_angle, 0]) cube([2, base[1] - side_wall, 2]);
                translate([-2 + rail_depth, 0, -rail_flat_h]) cube([2, base[1] - side_wall, rail_flat_h]);
            }
            translate([-5 + rail_depth, 0, 0]) cube([5, base[1] - side_wall, 5]);
        }

        pyramid_b = 3.23 * sqrt(2);
        pyramid_t = 1.75 * sqrt(2);
        pyramid_h = 1.0;
        pyramid_inset = 1.3 + 0.5;
        pyramid_step = 3.06;

        // The ramps to make slotting into the latch smooth
        translate([-1.75 / 2 + pyramid_inset, 0, -1.75 / 2]) rotate([-90, 0, 0]) rotate([0, 0, 45]) {
                    cylinder(r1=pyramid_b / 2, r2=pyramid_t / 2, h=pyramid_h, $fn=4);
                    cylinder(r=pyramid_t / 2, h=pyramid_step + pyramid_h, $fn=4);
                    translate([-0.1, 0.1, 0]) cylinder(r=pyramid_t / 2, h=pyramid_step + pyramid_h, $fn=4);
                }

        latch_l = 2.67;
        latch_d = pyramid_inset;
        latch_h = 2.85;
        latch_wall = 1.39;

        // The pocket that the latch bar drops into, including a 45 degree cut for printability
        translate([0, latch_wall, -latch_h]) cube([latch_d, latch_l, latch_h]);
        if (make_printable) {
            translate([latch_d, latch_wall + latch_l, -latch_h]) rotate([0, 0, -180 + 45]) translate([0, -latch_l, 0]) cube([latch_d * 2, latch_l, latch_h]);
        }
    }
}
