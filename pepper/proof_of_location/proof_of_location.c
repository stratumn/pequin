#include <stdint.h>

/*
  Proof of location.
  With this circuit, the prover can prove that his location is within an allowed area.
  The prover's location comes from his private input (only known to the prover).
  We assume that a hardware secure module will provide a trusted tamper-proof location.
  The verifier's input (challenge) is the allowed area.
  The verifier will provide multiple inputs (for each authorized area).
 */

// Constants
#define AREAS_COUNT 3

typedef struct _Point {
    uint32_t X;
    uint32_t Y;
} Point;

// Area represents an allowed area.
// (X, Y) is the center of the area and RADIUS is the allowed radius.
// For simplicity we use a square area instead of a circle.
typedef struct _Area {
    uint32_t Radius;
    Point Center;
} Area;

// In represents a list of allowed areas.
struct In {
    uint32_t Radius[AREAS_COUNT];
    uint32_t X[AREAS_COUNT];
    uint32_t Y[AREAS_COUNT];
};

// Out is 1 if private location is in one of the input areas, 0 otherwise.
struct Out {
    uint32_t valid;
};

// Get the user's location from an external computation.
// See exo_compute.txt for details.
// I placed a script named "exo0" in bin/ that returns a sample location:
// #!/bin/bash
// # This is the X coordinate
// echo 3
// # This is the Y coordinate
// echo 3
Point get_current_location() {
    uint32_t current_location[2];
    // These must be statically allocated to compile,
    // even though we don't need them.
    uint32_t exo0_input1[1] = {1};
    uint32_t *exo0_inputs[1] = {exo0_input1};
    uint32_t exo0_inputs_lengths[1] = {1};

    exo_compute(exo0_inputs, exo0_inputs_lengths, current_location, 0);

    Point p;
    p.X = current_location[0];
    p.Y = current_location[1];

    return p;
}

// is_in_area returns 1 if the input coordinates are inside the area.
int is_in_area(Point p, Area area) {
    int valid = 1;

    if (p.X < area.Center.X - area.Radius) {
        valid = 0;
    }

    if (area.Center.X + area.Radius < p.X) {
        valid = 0;
    }

    if (p.Y < area.Center.Y - area.Radius) {
        valid = 0;
    }

    if (area.Center.Y + area.Radius < p.Y) {
        valid = 0;
    }

    return valid;
}

// Compute will produce two lines in the output file.
// The first line is the return value of the method.
// The second line is the value of the output.
// Both lines will always be equal and represent the validity of the location (0 or 1).
int compute(struct In *input, struct Out *output) {
    Point location = get_current_location();
    uint16_t i;

    Area allowed_areas[AREAS_COUNT];
    for (i = 0; i < AREAS_COUNT; ++i) {
        Area area;
        area.Radius = input->Radius[i];
        area.Center.X = input->X[i];
        area.Center.Y = input->Y[i];
        allowed_areas[i] = area;
    }

    output->valid = 0;

    for (i = 0; i < AREAS_COUNT; ++i) {
        if (is_in_area(location, allowed_areas[i])) {
            output->valid = 1;
        }
    }

    return output->valid;
}
