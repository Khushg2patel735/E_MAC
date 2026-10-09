`ifndef AXIL_MAS_DEFINE_SV
`define AXIL_MAS_DEFINE_SV
  
  
  `define NO_OF_LANE      `DATA_WIDTH/8
  `define SIZE_WIDTH      8
  `define CLOCK_SKEW        1         //for skew
    //`define axil_mas_i_skew 20ns //0.02ns 
  //`define axil_mas_o_skew 20ns //0.02ns 
  
   
  typedef enum bit[1:0] { FIXED, INCR, WRAP} burst_type_enum; //for AWBURST and ARBURST
  
  typedef enum bit[1:0] {OKAY, EXOKAY, SLVERR, DECERR} response_e; //for BRESP and RRESP
						  
  typedef enum bit {SEQ,NON_SEQ} trans_type; //NON_SEQ-non_sequential_transaction, SEQ-sequential transaction 
  

 
  
`endif //AXIL_MAS_DEFINE_SV
