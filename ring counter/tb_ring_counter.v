```verilog
`timescale 1ns/1ps

module tb_ring_counter;

    reg        clk;
    reg        reset;
    wire [3:0] q;

    // Instantiate Ring Counter
    ring_counter uut (
        .clk   (clk),
        .reset (reset),
        .q     (q)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk   = 0;
        reset = 1;

        // Apply reset
        #10;
        reset = 0;

        // Run simulation
        #50;

        $finish;
    end

    // Display output
    initial begin
        $monitor("Time = %0t | Reset = %b | Q = %b",
                 $time, reset, q);
    end

endmodule