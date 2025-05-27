`timescale 1ns / 1ps

module two_bit_up_counter(
  input clock,
  input in,          // Unused for now
  input reset,
  output reg [1:0] out  // 2-bit output to reflect counter value
);

  // State definitions (2-bit states)
  parameter s0 = 2'd0,
            s1 = 2'd1,
            s2 = 2'd2,
            s3 = 2'd3;

  reg [1:0] cs, ns;

  // Combinational next-state logic
  always @(*) begin
    case (cs)
      s0: ns = s1;
      s1: ns = s2;
      s2: ns = s3;
      s3: ns = s0;
      default: ns = s0;
    endcase
  end

  // Sequential state update
  always @(posedge clock or posedge reset) begin
    if (reset)
      cs <= s0;
    else
      cs <= ns;
  end

  // Output is just the current state (count value)
  always @(*) begin
    out = cs;
  end

endmodule
