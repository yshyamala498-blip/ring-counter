```verilog
// 4-bit Ring Counter
// Sequence: 1000 -> 0100 -> 0010 -> 0001 -> 1000

module ring_counter (
    input  wire       clk,
    input  wire       reset,
    output reg  [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b1000;          // Initialize one bit to 1
        else
            q <= {q[2:0], q[3]};    // Circular shift
    end

endmodule