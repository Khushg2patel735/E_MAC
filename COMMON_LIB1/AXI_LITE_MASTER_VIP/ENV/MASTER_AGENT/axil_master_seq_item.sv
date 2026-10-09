

`ifndef AXIL_MASTER_SEQ_ITEM_SV
`define AXIL_MASTER_SEQ_ITEM_SV

class axil_master_seq_item #(shortint ADDR_SIZE=32,DATA_SIZE=32,ID_SIZE=32) extends uvm_sequence_item;
  
  
  //------------ write address channel ------------------------ //
  
  //Write address ID. awid signal is the identification tag
  rand bit [(ID_SIZE-1):0] awid;
  
  //The write address gives the address of the first transfer in a write burst transaction
  rand bit [(ADDR_SIZE-1):0] write_start_addr;
  
  //no_of_bytes indicates 2**size
  rand bit [(`SIZE_WIDTH-1):0] no_of_wbytes;
  rand bit [(`SIZE_WIDTH-1):0] no_of_rbytes;
  
  //total_bytes indicates no_of_bytes * burst_len
  rand shortint unsigned total_wbytes;
  rand shortint unsigned total_rbytes;
  
  //burst_len indicates exact number of transfers in a burst
  shortint unsigned wburst_len;
  shortint unsigned rburst_len; 
  
  //burst_type_e indicates burst_type(FIXED, INCR, WRAP)
  rand burst_type_enum wburst_type_e;
  rand burst_type_enum rburst_type_e;
  
  //------------ write data channel ------------------------ //
  
  //Write Data ID. wid indicate identification tag. (Supported only in AXI3)
  bit [(ID_SIZE-1):0] wid;
  
  //Write_Data
  rand bit [(DATA_SIZE-1):0] write_data_q [$];
  
  //Write_Strobe indicates the byte lanes of the data bus that contain valid information
  bit [((DATA_SIZE/8)-1):0] write_strb_q [$];
  
  //Write response ID. bid indicate identification tag.(for sampling purpose)
  bit [(ID_SIZE-1):0] bid;
  response_e wresp;
  
  //------------ read address channel ------------------------ //
    
  //Read address ID. arid signal is the identification tag
  rand bit [(ID_SIZE-1):0] arid;

  //The read address gives the address of the first transfer in a read burst transaction
  rand bit [(ADDR_SIZE-1):0] read_start_addr;
  bit [(DATA_SIZE-1):0] read_data_q [$];
  
  //------------ read data channel ------------------------ //

  //Write response ID. bid indicate identification tag.(for sampling purpose)
  bit [(ID_SIZE-1):0] rid;
  response_e rresp;


  //----------------- constraints ---------------------//
  constraint DATA_SIZE_C { write_data_q.size() == (((total_wbytes%no_of_wbytes)==0) ? 
                            (int'(total_wbytes/no_of_wbytes)) :
                            (int'(total_wbytes/no_of_wbytes) + '1));
                              }
                   
  `uvm_object_param_utils_begin(axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE))
    `uvm_field_int(awid,UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(write_start_addr,UVM_ALL_ON)
    `uvm_field_enum(burst_type_enum, wburst_type_e, UVM_ALL_ON)
    `uvm_field_int(no_of_wbytes,UVM_ALL_ON)
    `uvm_field_int(total_wbytes,UVM_ALL_ON)
    `uvm_field_int(wburst_len,UVM_ALL_ON)  
		`uvm_field_int(wid,UVM_ALL_ON)
		`uvm_field_queue_int(write_data_q,UVM_ALL_ON)
		`uvm_field_queue_int(write_strb_q,UVM_ALL_ON)
    `uvm_field_int(bid,UVM_ALL_ON)
    `uvm_field_enum(response_e, wresp, UVM_ALL_ON)
    `uvm_field_int(arid,UVM_ALL_ON)    
    `uvm_field_int(read_start_addr,UVM_ALL_ON)
    `uvm_field_enum(burst_type_enum, rburst_type_e, UVM_ALL_ON)
    `uvm_field_int(no_of_rbytes, UVM_ALL_ON)
    `uvm_field_int(total_rbytes, UVM_ALL_ON)
    `uvm_field_int(rburst_len, UVM_ALL_ON)
    `uvm_field_int(rid,UVM_ALL_ON)
    `uvm_field_queue_int(read_data_q, UVM_ALL_ON)
    `uvm_field_enum(response_e, rresp, UVM_ALL_ON)
	`uvm_object_utils_end
  
  
	function new (string name = "axil_master_seq_item");
		super.new(name);
	endfunction
  
  function void post_randomize();
    length_calc();
    storb_calc();
  endfunction   
    
  function void length_calc();
    wburst_len = ((total_wbytes % no_of_wbytes)==0) ?  (int'(total_wbytes / no_of_wbytes)) :
                                                          (int'(total_wbytes / no_of_wbytes) + '1);
    rburst_len = ((total_rbytes % no_of_rbytes)==0) ?  (int'(total_rbytes / no_of_rbytes)) :
                                                          (int'(total_rbytes / no_of_rbytes) + '1);
  endfunction
  
  function void storb_calc();
    int j;
    bit [((DATA_SIZE/8)-1):0] start_lan;
    //{>>{write_strb_q}} = ;
    repeat(wburst_len) write_strb_q.push_back(0);
    start_lan = write_start_addr%(DATA_SIZE/8);
    j = start_lan% no_of_wbytes;
    foreach(write_strb_q[k]) begin
      for(int i=j; i<no_of_wbytes; i++) begin
        write_strb_q[k][start_lan] = 1'b1;
        start_lan++;
        if (start_lan == ((DATA_SIZE/8))) start_lan=0;
        j=0;
      end
    end
  endfunction
  
endclass : axil_master_seq_item

`endif //AXIL_MASTER_SEQ_ITEM_SV
