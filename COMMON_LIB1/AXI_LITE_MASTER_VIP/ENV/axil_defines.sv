`ifndef AXIL_DEFINE_SV
`define AXIL_DEFINE_SV
  int no_of_iteration = 2;
  
  `define NUM_AXIL_MASTER_AGENTS 1

//  -----------------delays --------------------
  `define CLK_PERIOD 40ns 
 `define axil_mas_i_skew 0.02ns//20ns //0.02ns
 `define axil_mas_o_skew 0.02ns//20ns //0.02ns 
  
`endif //AXIL_DEFINE_SV
