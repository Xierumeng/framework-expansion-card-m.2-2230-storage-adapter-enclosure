include <anti_z_fighting.scad>

// The rail cutout in the sides of the card
module rail(card, distance_from_end = 0, make_printable = true) {
    rail_depth = 0.81;
    rail_flat_h = 0.32;

    mirror([0, 1, 0]) {

        // The rail that holds the card
        bottom_angle = 43.54;
        difference() {
            start = -anti_z_fighting_value;

            distance_from_end = (distance_from_end > 0) ? distance_from_end : -anti_z_fighting_value;
            end = card[1] - distance_from_end - start;

            // Removing
            union() {
                translate([rail_depth, start, -rail_flat_h])
                    rotate([0, 180 + bottom_angle, 0])
                        cube([2, end, 2]);

                translate([-2 + rail_depth, start, -rail_flat_h])
                    cube([2, end, rail_flat_h]);
            }

            // Re-adding
            translate([-5 + rail_depth, start, 0])
                cube([5, end, 5]);
        }

        pyramid_inset = 1.3 + 0.5;

        // The ramps to make slotting into the latch smooth
        translate([-1.75 / 2 + pyramid_inset, 0, -1.75 / 2]) {
            width_bottom = 3.23;
            width_top = 1.75;
            height = 1.0;

            __ramp_pyramoid(width_bottom, width_top, height);

            width_extra = 0.05 + anti_z_fighting_value;
            height_straight = 1.5; // Large enough to overlap
            translate([-width_extra / 2, height_straight / 2 - anti_z_fighting_value, 0])
                cube([width_top + width_extra, height_straight, width_top], center=true);
        }

        latch_l = 2.67;
        latch_d = pyramid_inset;
        latch_h = 2.85;
        latch_wall = 1.39;

        // The pocket that the latch bar drops into, including a 45 degree cut for printability
        translate([-anti_z_fighting_value, latch_wall, -latch_h])
            cube([latch_d + anti_z_fighting_value, latch_l, latch_h]);

        if (make_printable) {
            translate([latch_d, latch_wall + latch_l, -latch_h])
                rotate([0, 0, -180 + 45])
                    translate([0, -latch_l, 0])
                        cube([latch_d * 2, latch_l, latch_h]);
        }
    }
}

module __ramp_pyramoid(width_bottom, width_top, height) {
    points = [
        // Anti Z-fighting
        [width_bottom / 2, -anti_z_fighting_value, width_bottom / 2],
        [-width_bottom / 2, -anti_z_fighting_value, width_bottom / 2],
        [-width_bottom / 2, -anti_z_fighting_value, -width_bottom / 2],
        [width_bottom / 2, -anti_z_fighting_value, -width_bottom / 2],
        // Front
        [width_bottom / 2, 0, width_bottom / 2],
        [-width_bottom / 2, 0, width_bottom / 2],
        [-width_bottom / 2, 0, -width_bottom / 2],
        [width_bottom / 2, 0, -width_bottom / 2],
        // Rail
        [width_top / 2, height, width_top / 2],
        [-width_bottom / 2, height, width_top / 2], // Stretched
        [-width_bottom / 2, height, -width_top / 2], // Stretched
        [width_top / 2, height, -width_top / 2],
    ];

    faces = [
        [0, 1, 2, 3], // Front
        [11, 10, 9, 8], // Back
        // Perpendicular
        [0, 4, 5, 1], // Top
        [1, 5, 6, 2], // Left
        [2, 6, 7, 3], // Bottom
        [0, 3, 7, 4], // Right
        // Sloped
        [4, 8, 9, 5], // Top
        [5, 9, 10, 6], // Left
        [6, 10, 11, 7], // Bottom
        [4, 7, 11, 8], // Right
    ];

    polyhedron(points=points, faces=faces);
}
