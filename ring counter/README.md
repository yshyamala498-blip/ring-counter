# 🔄 4-Bit Ring Counter Using Verilog HDL

## 📌 Overview

This project implements a **4-bit Ring Counter** using **Verilog HDL**.

A ring counter is a type of shift register where the output of the last flip-flop is connected back to the input of the first flip-flop. A single `1` circulates through the register with every clock pulse.

The counter follows the sequence:

```text
1000 → 0001 → 0010 → 0100 → 1000 → ...
```

## ✨ Features

* 4-bit ring counter
* Designed using Verilog HDL
* Positive-edge triggered clock
* Asynchronous reset
* One-hot output sequence
* Includes a Verilog testbench
* Suitable for simulation and FPGA implementation

## 📁 Project Structure

```text
4-bit-ring-counter/
│
├── ring_counter.v
├── tb_ring_counter.v
├── ring_counter_waveform.png
└── README.md
```

## ⚙️ Working Principle

The ring counter uses a 4-bit register.

When reset is activated, the counter is initialized to:

```text
1000
```

For every positive edge of the clock, the bit pattern is shifted circularly:

```text
1000
  ↓
0001
  ↓
0010
  ↓
0100
  ↓
1000
```

This cycle repeats continuously.

### 🔢 State Sequence

| Clock | Q[3:0] |
| :---: | :----: |
| Reset | `1000` |
|   1   | `0001` |
|   2   | `0010` |
|   3   | `0100` |
|   4   | `1000` |
|   5   | `0001` |
|   6   | `0010` |
|   7   | `0100` |

## 💻 Verilog Design

### `ring_counter.v`

```verilog
module ring_counter (
    input  wire       clk,
    input  wire       reset,
    output reg  [3:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b1000;
        else
            q <= {q[2:0], q[3]};
    end

endmodule
```

## 🧪 Testbench

### `tb_ring_counter.v`

```verilog
`timescale 1ns/1ps

module tb_ring_counter;

    reg        clk;
    reg        reset;
    wire [3:0] q;

    ring_counter uut (
        .clk   (clk),
        .reset (reset),
        .q     (q)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;

        // Reset
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