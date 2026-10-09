

`ifndef AXIL_MASTER_BASE_SEQUENCE_SVH
`define AXIL_MASTER_BASE_SEQUENCE_SVH

class axil_master_base_sequence #(shortint ADDR_SIZE=32,DATA_SIZE=32,ID_SIZE=32) extends uvm_sequence #(axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE));

  `uvm_object_param_utils(axil_master_base_sequence #(ADDR_SIZE,DATA_SIZE,ID_SIZE))
	//`uvm_object_utils_end
	
	function new(string name = "axil_master_base_sequence");
		super.new(name);
	endfunction : new
	
  int cnt;
  
  virtual task body();
    use_response_handler(1);
    begin

     //write transfer 
     `uvm_create(req);
     `uvm_rand_send_with(req, { awid == 'hF; write_start_addr == 'h6; no_of_wbytes == 'h20;
                          total_wbytes == 'h20; wburst_type_e == FIXED; no_of_rbytes == 'h0; total_rbytes == 'h0; 
                         arid == 'h0; read_start_addr == 'h0;
                        }
                  )
				  
	 `uvm_rand_send_with(req, { awid == 'h3; write_start_addr == 'h14; no_of_wbytes == 'h20;
                     total_wbytes == 'h80; wburst_type_e == FIXED; no_of_rbytes == 'h0; total_rbytes == 'h0; 
                    arid == 'h0; read_start_addr == 'h0;
                   }
             )
     wait_for_trans_to_finish(1);
     
    //read transfer
       /*`uvm_create(req);
      `uvm_rand_send_with(req, { awid == 'h0; write_start_addr == 'h0; no_of_wbytes == 'h1; total_wbytes == 'h1; no_of_rbytes == 'h20;
                          total_rbytes == 'h20; rburst_type_e == FIXED; 
                          arid == 'hF+1; read_start_addr inside {[20:30]};
                        }
                  )
      wait_for_trans_to_finish(1);*/
 
     //write transfer 
     `uvm_create(req);
     `uvm_rand_send_with(req, { awid == 'h6; write_start_addr == 'h7; no_of_wbytes == 'h20;
                          total_wbytes == 'h20; wburst_type_e == FIXED; no_of_rbytes == 'h0; total_rbytes == 'h0; 
                         arid == 'h0; read_start_addr == 'h0;
                        }
                  )
     //wait_for_trans_to_finish(1);        
     
     //read transfer
     /*`uvm_create(req);
     `uvm_rand_send_with(req, { awid == 'h0; write_start_addr == 'h0; no_of_wbytes == 'h1; total_wbytes == 'h1; no_of_rbytes == 'h20;
                          total_rbytes == 'h20; rburst_type_e == INCR; 
                          arid == 'h12; read_start_addr inside {[20:30]};
                        }
                  )
      wait_for_trans_to_finish(1);*/

  end
    
    #200;
      
	endtask
  
  task wait_for_trans_to_finish(int itr);
    wait(cnt==itr);
    cnt = 0;
  endtask
  
  function void response_handler(uvm_sequence_item response);
     cnt++;
     `uvm_info(get_type_name(), $sformatf("cnt = %0d, response = %0s", cnt, response.sprint()), UVM_DEBUG)
  endfunction: response_handler
  
 
  
endclass : axil_master_base_sequence

`endif  //AXIL_MASTER_BASE_SEQUENCE_SVH
	
