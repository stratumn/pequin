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

// Area represents an allowed area.
// (X, Y) is the center of the area and RADIUS is the allowed radius.
// For simplicity we use a square area instead of a circle.
typedef struct _Area {
    uint32_t RADIUS;
    uint32_t X;
    uint32_t Y;        
} Area;

// In represents a list of allowed areas.
struct In {
    uint32_t RADIUS[AREAS_COUNT];
    uint32_t X[AREAS_COUNT];
    uint32_t Y[AREAS_COUNT];
};

// Out is 1 if private location is in one of the input areas, 0 otherwise.
struct Out {
    uint32_t valid;
};

// is_in_area returns 1 if the input coordinates are inside the area.
int is_in_area(uint32_t x, uint32_t y, Area area) {
    int valid = 1;

    if (x < area.X - area.RADIUS) {
        valid = 0;
    }

    if (area.X + area.RADIUS < x) {
        valid = 0;
    }

    if (y < area.Y - area.RADIUS) {
        valid = 0;
    }

    if (area.Y + area.RADIUS < y) {
        valid = 0;
    }

    return valid;
}

// Compute will produce two lines in the output file.
// The first line is the return value of the method.
// The second line is the value of the output.
// Both lines will always be equal and represent the validity of the location (0 or 1).
int compute(struct In *input, struct Out *output) {
    // TODO: get from private inputs
    uint32_t xp = 42;
    uint32_t yp = 42;

    uint16_t i;

    Area allowed_areas[AREAS_COUNT];
    for (i = 0; i < AREAS_COUNT; ++i) {
        Area area;
        area.RADIUS = input->RADIUS[i];
        area.X = input->X[i];
        area.Y = input->Y[i];
        allowed_areas[i] = area;
    }

    output->valid = 0;

    for (i = 0; i < AREAS_COUNT; ++i) {
        if (is_in_area(xp, yp, allowed_areas[i])) {
            output->valid = 1;
        }
    }

    return output->valid;
}
