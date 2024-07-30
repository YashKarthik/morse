#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_fst_c.h>
#include "Vblinker.h"

#define MAX_SIM_TIME 150000000
int sim_time = 0;
int posedge_cnt = 0;

int main(int argc, char** argv, char** env) {
    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vblinker *circuit = new Vblinker;

    Verilated::traceEverOn(true);
    VerilatedFstC *m_trace = new VerilatedFstC;
    circuit->trace(m_trace, 5);
    m_trace->open("blinker-trace.fst");

    circuit->i_read = 1;
    circuit->i_s3 = 1;
    while (sim_time < MAX_SIM_TIME) {
        circuit->i_clk ^= 1;
        circuit->morse_code = 0;
        circuit->i_rst = 0;

        if (circuit->test_clk == 1) {
            circuit->i_read = 0;
        }

        if (circuit->ready == 1) {
            circuit->i_s3 = 0;
        }

        circuit->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete circuit;
    exit(EXIT_SUCCESS);
}
