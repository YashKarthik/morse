#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtranslator.h"

int main(int argc, char** argv, char** env) {
    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vtranslator *circuit = new Vtranslator;

    Verilated::traceEverOn(true);
    VerilatedVcdC *trace = new VerilatedVcdC;
    circuit->trace(trace, 5);
    trace->open("translator-trace.vcd");

    int s0 = 48;
    int e0 = 57;
    int s1 = 65;
    int e1 = 90;
    int s2 = 97;
    int e2 = 122;

    for (int i = s0; i <= e0; i++) {
        circuit->in_ascii = i;
        circuit->eval();
        trace->dump(i);
    }

    for (int i = s1; i <= e1; i++) {
        circuit->in_ascii = i;
        circuit->eval();
        trace->dump(i);
    }

    for (int i = s2; i <= e2; i++) {
        circuit->in_ascii = i;
        circuit->eval();
        trace->dump(i);
    }

    trace->close();
    delete circuit;
    exit(EXIT_SUCCESS);
}
