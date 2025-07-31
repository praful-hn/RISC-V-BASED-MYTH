\m5_TLV_version 1d: tl-x.org
\m5
\SV
   m5_makerchip_module
\TLV
   |calc
      @0
         $reset = *reset;
         $val2[31:0] = $rand2[3:0];

         // When reset is active, val1 must also be cleared to 0.
         // Otherwise, it gets the value of $out from the previous cycle.
         //$val1[31:0] = $reset ? 32'b0 : >>1$out[31:0];

         //inputs to 4to1 mux
         $sum[31:0]   = $val1[31:0] + $val2[31:0];
         $diff[31:0]  = $val1[31:0] - $val2[31:0];
         $prod[31:0]  = $val1[31:0] * $val2[31:0];
         $quot[31:0]  = $val1[31:0] / $val2[31:0];

         // output - nested ternary operator
         // On reset, force $out to 0. Otherwise, perform the calculation.
         $out[31:0] = $reset ? 32'b0 :
                         ($op[1]) ? ($op[0] ? $quot[31:0] : $prod[31:0]) :
                                    ($op[0] ? $diff[31:0] : $sum[31:0]);

         // Assert these to end simulation (before the cycle limit).
         *passed = *cyc_cnt > 40;
         *failed = 1'b0;
\SV
   endmodule
