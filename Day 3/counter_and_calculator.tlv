\m5_TLV_version 1d: tl-x.org
\m5
\SV
   m5_makerchip_module
\TLV
   // Define inputs that were missing
   //$rand2[3:0];
   //$op[1:0];

   |calc
      @0
         $reset = *reset;
         
         //counter
         $cnt[31:0] = $reset ? 32'b0 : >>1$cnt + 1;
         
         //calculator
         $val2[31:0] = $rand2[3:0];
         $val1[31:0] = >>1$out[31:0];
         
         //inputs to 4to1 mux
         $sum[31:0]   = $val1[31:0] + $val2[31:0];
         $diff[31:0]  = $val1[31:0] - $val2[31:0];
         $prod[31:0]  = $val1[31:0] * $val2[31:0];
         $quot[31:0]  = $val1[31:0] / $val2[31:0];
         
         $out[31:0] = $reset ? 32'b0 :
                         ($op[1]) ? ($op[0] ? $quot[31:0] : $prod[31:0]) :
                                    ($op[0] ? $diff[31:0] : $sum[31:0]);
         
         // Assert these to end simulation (before the cycle limit).
         *passed = *cyc_cnt > 40;
         *failed = 1'b0;
\SV
   endmodule