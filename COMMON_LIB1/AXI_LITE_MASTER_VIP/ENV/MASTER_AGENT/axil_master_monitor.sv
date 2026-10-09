

`ifndef AXIL_MASTER_MONITOR_SVH
`define AXIL_MASTER_MONITOR_SVH

class axil_master_monitor #(shortint ADDR_SIZE=32,DATA_SIZE=32,ID_SIZE=32) extends uvm_monitor;
	
	//sequence item class handle
	axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) write_q[$]; //write transection monitoring 
	axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) read_q[$]; //read transection monitoring
	
	//virtual interface used to drive and view HDL signals.
	virtual axil_master_if vif;
	
	trans_type trans_type_e;
	
	uvm_analysis_port #(axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE)) item_collected_port;

  event req_phase_ev;

	//provide implementations of virtual methods such as get_type_name and create
	`uvm_component_param_utils(axil_master_monitor #(ADDR_SIZE,DATA_SIZE,ID_SIZE))
	
	//new - constructor
	function new (string name, uvm_component parent);
		super.new(name,parent);
		item_collected_port = new("item_collected_port",this);
	endfunction	: new 
	
	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
	endfunction: build_phase
	
 	//run_phase
	virtual task run_phase(uvm_phase phase);
			wait_for_reset_release();
			 
     forever begin
        fork:RESET
          begin
            collect_transcation();
            //item_collected_port.write(item);
          end
        join_none
        wait_for_reset_assertion();
        disable RESET;
    
        wait_for_reset_release();
     end   
	endtask : run_phase 
	 
  task wait_for_reset_assertion();
    @(negedge vif.ARESETn);
  endtask : wait_for_reset_assertion

  task wait_for_reset_release();
    @(posedge vif.ARESETn);
  endtask : wait_for_reset_release

	//collect_transcation task
	task collect_transcation();
    fork
       write_req_phase();
       write_data_phase();
       write_rsp_phase();
       read_req_phase();
       read_rsp_phase();
    join
	endtask : collect_transcation	
	
  task write_req_phase();
     int i;
     forever begin
       @( vif.mon_cb iff vif.mon_cb.awvalid);
       if (!vif.mon_cb.awready) @( vif.mon_cb iff vif.mon_cb.awready);
       write_q[i] = axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create($sformatf("write_q[%0d]",i)); 
       ->req_phase_ev;
       write_q[i].awid              = vif.mon_cb.awid;
       write_q[i].write_start_addr  = vif.mon_cb.awaddr;
       write_q[i].wburst_len        = vif.mon_cb.awlen;
       write_q[i].wburst_type_e     = burst_type_enum'(vif.mon_cb.awburst);
       write_q[i].no_of_wbytes      = 2**(vif.mon_cb.awsize);
       write_q[i].total_wbytes      = (write_q[i].no_of_wbytes * vif.mon_cb.awlen);
       `uvm_info(get_full_name(),$sformatf("monitor write req ------- : %0s",write_q[i].sprint()),UVM_DEBUG)
       i++;
     end
  endtask : write_req_phase

  task write_data_phase();
     int i;
	   trans_type_e = NON_SEQ;
     fork
	    forever begin
         @( vif.mon_cb iff vif.mon_cb.wready);
         if (!vif.mon_cb.wvalid) @( vif.mon_cb iff vif.mon_cb.wvalid);
         if (trans_type_e == NON_SEQ)
			     wait(req_phase_ev.triggered);
			   trans_type_e = SEQ;
         write_q[i].wid  = vif.mon_cb.wid;
         write_q[i].write_data_q.push_back(vif.wdata);
         write_q[i].write_strb_q.push_back(vif.wstrb);
         `uvm_info(get_full_name(),$sformatf("write data phase monitor data------ : %s",write_q[i].sprint()),UVM_DEBUG)
         if(vif.mon_cb.wlast) begin
		       i++;
		       trans_type_e = NON_SEQ;
		     end
      end
	   join
  endtask : write_data_phase

  task write_rsp_phase();
     int i;
     axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) item_collected;
     forever begin
        @(vif.mon_cb iff vif.mon_cb.bvalid);
        if (!vif.mon_cb.bready) @(vif.mon_cb iff vif.mon_cb.bready);
        write_q[i].bid = vif.bid;
        write_q[i].wresp = response_e'(vif.mon_cb.bresp);

	$cast(item_collected,write_q[i].clone());
	item_collected_port.write(item_collected);

        `uvm_info("COLLECTED_WRITE_TRANS",$sformatf("write rsp phase monitor response------ : %s",write_q[i].sprint()),UVM_DEBUG)
        i++;
     end
  endtask : write_rsp_phase;

  task read_req_phase();
     int i;
     forever begin
      @( vif.mon_cb iff vif.mon_cb.arvalid);
      if (!vif.mon_cb.arready) @(vif.mon_cb iff vif.mon_cb.arready);
      read_q[i] = axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create($sformatf("read_q[%0d]",i));  
      read_q[i].arid              = vif.mon_cb.arid;
      read_q[i].read_start_addr   = vif.mon_cb.araddr;
      read_q[i].rburst_len        = vif.mon_cb.arlen;
      read_q[i].rburst_type_e     = burst_type_enum'(vif.mon_cb.arburst);
      read_q[i].no_of_rbytes      = 2**(vif.mon_cb.arsize);
      read_q[i].total_rbytes      = (read_q[i].no_of_rbytes * vif.mon_cb.arlen);
      `uvm_info(get_full_name(),$sformatf("monitor read req--------- : %0s",read_q[i].sprint()),UVM_DEBUG)
      i++;
     end
  endtask : read_req_phase

  task read_rsp_phase();
     int i;
     axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) item_collected;
     fork 
	    forever begin
        @(vif.mon_cb iff vif.mon_cb.rvalid);
        if (!vif.mon_cb.rready) @(vif.mon_cb iff vif.mon_cb.rready);
        read_q[i].rid = vif.rid;
        read_q[i].read_data_q.push_back(vif.mon_cb.rdata);
        read_q[i].rresp = response_e'(vif.mon_cb.rresp);

	$cast(item_collected,read_q[i].clone());
	item_collected_port.write(item_collected);

        `uvm_info("COLLECTED_READ_TRANS",$sformatf("monitor read data & rsp : %0s",read_q[i].sprint()),UVM_DEBUG)

        if (vif.mon_cb.rlast) begin i++; end
       end
	  join
  endtask : read_rsp_phase

endclass : axil_master_monitor

`endif //AXIL_MASTER_MONITOR_SVH
