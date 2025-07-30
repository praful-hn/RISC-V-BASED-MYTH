\m5_TLV_version 1d: tl-x.org
\m5
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @0
         $reset = *reset;
         //limiting input variable randomize to 4 bits
         $val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];
         //inputs to 4to1 mux
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
         //output - nested ternary operator
         $out[31:0] = ($op[1]) ? ($op[0] ? $quot[31:0] : $prod[31:0]) : ($op[0] ? $diff[31:0] : $sum[31:0]);
         // Assert these to end simulation (before the cycle limit).
         *passed = *cyc_cnt > 40;
         *failed = 1'b0;
\SV
   endmodule
