`ifndef AXIL_MASTER_DRIVER_SVH
`define AXIL_MASTER_DRIVER_SVH

class axil_master_driver #(shortint ADDR_SIZE=32,DATA_SIZE=32,ID_SIZE=32) extends uvm_driver #(axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE));
  
	//virtual interface used to drive and view HDL signals.
	virtual axil_master_if vif;

	//master config handle
	axil_mas_config m_cfg;

       //uvm event write event
         uvm_event wr_tx_item_done_ev;
       //uvm_event read event
         uvm_event rd_tx_item_done_ev;
  
  //sequence item class handle as a queue array
  axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) awaddr_phase_q[$];
	axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) wrdata_phase_q[$];
	axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) wrresp_phase_q[$];
	axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) rdaddr_phase_q[$];
	axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) rddata_phase_q[$];
  
  axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) wr_phase[16];
  axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) rd_phase[16];
  
  axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) rsp;
    

	//provide implementations of virtual methods such as get_type_name and create
	`uvm_component_param_utils(axil_master_driver #(ADDR_SIZE,DATA_SIZE,ID_SIZE))
		
	//new - constructor
	function new (string name="axil_master_driver", uvm_component parent);
	    super.new(name, parent);
            wr_tx_item_done_ev = new();
            rd_tx_item_done_ev = new();
	endfunction	: new
	
	//build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    rsp = axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create("rsp");
		
	endfunction: build_phase
	
  //run_phase
  virtual task run_phase(uvm_phase phase);
    int i;
    axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) trans_h;
    
    //initilize all design inputs
    initialization();

    #1;  //to avoid initial reset detection at 0 simulation time
    //wait for reset release
    wait_for_reset_release();

    forever begin     
      fork : RUN
        //tread 1
        forever begin
	      seq_item_port.get_next_item(req);
              $cast(trans_h,req.clone());
              `uvm_info(get_full_name(),$sformatf("data recive by driver : %0s",req.sprint()),UVM_DEBUG)
              if(trans_h.no_of_wbytes != 'b0) begin 
                awaddr_phase_q.push_back(trans_h);
                wrdata_phase_q.push_back(trans_h);
                i++;
              end  
              if(trans_h.no_of_rbytes != 'b0) rdaddr_phase_q.push_back(trans_h);
              rsp.copy(req);
              rsp.set_id_info(req);
             // fork
               // drive_tx();
              //join_none
              if(m_cfg.driver_type_e == PIPELINE_DRV_DISENB) begin	 //PIPELINE_DRV_ENB      
                fork
                  begin
                     if (trans_h.no_of_wbytes != 0) 
                      wr_tx_item_done_ev.wait_trigger();
                  end
                  begin
                     if (trans_h.no_of_rbytes != 0) 
                      rd_tx_item_done_ev.wait_trigger();
                  end
                join_any
                 if(trans_h.no_of_wbytes != 0 && trans_h.no_of_rbytes != 0) wait fork;
              end
              seq_item_port.item_done();
         end
     
        //thread 2
        drive_tx(); 

      join_none 
 
      wait_for_reset_assertion();
      disable RUN;
    
      wait_for_reset_release();
              
      end 
  endtask	: run_phase
  
  task drive_tx();
    `uvm_info("AXIL_MASTER_DRIVER", "drive_tx", UVM_DEBUG)
      fork : RESET
        write_addr_phase();
        write_data_phase();
        write_resp_phase();
        read_addr_phase();
        read_data_phase();
      join 

    `uvm_info("AXIL_MASTER_DRIVER", "drive_tx : completed", UVM_DEBUG);
  endtask : drive_tx
  
  task wait_for_reset_assertion();
    @(negedge vif.ARESETn);
  endtask : wait_for_reset_assertion

  task wait_for_reset_release();
    @(posedge vif.ARESETn);
    initialization(); 
  endtask : wait_for_reset_release

  //drive value 0 on all the master signal and delete all the transaction in buffer
  task initialization();
    vif.awvalid <= 1'b0;
    vif.awid    <= 0;
    vif.awsize  <= 0;
    vif.awlen   <= 0;
    vif.awburst <= 0;
    vif.awaddr  <= 0;
    vif.wvalid  <= 1'b0;
    vif.wid     <= 0;
    vif.wlast   <= 1'b0;
    vif.wdata   <= 0;
    vif.wstrb   <= 0;
    vif.bready  <= 1'b0;
    vif.arvalid <= 1'b0;
    vif.arid    <= 0;
    vif.arsize  <= 0;
    vif.arlen   <= 0;
    vif.arburst <= 0; 
    vif.araddr  <= 0;
    vif.rready  <= 1'b0;
  endtask : initialization

  //for write address channel
  task write_addr_phase();
    axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) req;
    trans_type trans_type_e;    

    trans_type_e = NON_SEQ;
    forever begin           //driving Write address channel data
      wait(awaddr_phase_q.size() != 0);
      if (trans_type_e == NON_SEQ) begin
        @(posedge vif.drv_cb);
      end  
      trans_type_e = SEQ;
      $cast(req,awaddr_phase_q.pop_front().clone());
      `uvm_info("WRITE_REQ_PHASE",$sformatf(" : write req phase req : %0s",req.sprint()),UVM_DEBUG);
      vif.drv_cb.awvalid <= 1'b1;
      vif.drv_cb.awid    <= req.awid;
      vif.drv_cb.awaddr  <= req.write_start_addr;
      vif.drv_cb.awlen   <= req.wburst_len;   
      vif.drv_cb.awsize  <= $clog2(req.no_of_wbytes);   
      vif.drv_cb.awburst <= req.wburst_type_e;
      
      //check awready is not high then wait other wise no
      @(posedge vif.drv_cb iff vif.drv_cb.awready);
        begin
          if (awaddr_phase_q.size == 0) begin
             trans_type_e = NON_SEQ;
            vif.drv_cb.awvalid <= 0;
          end
        end
      
    end
        
  endtask : write_addr_phase
  
  //write data channel
  task write_data_phase();
   axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE)  req;
   trans_type trans_type_e;    

    trans_type_e = NON_SEQ;
   forever begin
      
      wait(wrdata_phase_q.size() != 0);
      $cast(req,wrdata_phase_q.pop_front().clone());
      `uvm_info("WRITE_DATA_PHASE",$sformatf(" : write data phase req : %0s",req.sprint()),UVM_DEBUG);
      for(int i=0; i<req.wburst_len; i++) begin
          if (trans_type_e == NON_SEQ) begin
            @(posedge vif.drv_cb);
          end
        trans_type_e = SEQ;
        vif.drv_cb.wvalid <= 1;
        vif.drv_cb.wlast  <= 0;
        vif.drv_cb.wid    <= req.awid;
        vif.drv_cb.wdata  <= req.write_data_q.pop_front();
        vif.drv_cb.wstrb    <= req.write_strb_q.pop_front();
        if(i==(req.wburst_len-1)) begin
          vif.drv_cb.wlast <= 1;
        end      
        @(posedge vif.drv_cb iff vif.drv_cb.wready);
      end
      
      if (wrdata_phase_q.size() == 0) begin 
        trans_type_e = NON_SEQ;
        vif.drv_cb.wlast <= 0;
        vif.drv_cb.wvalid <= 0;
      end
      
      wrresp_phase_q.push_back(req);
   end
  endtask : write_data_phase
  
  //write response channel
  task write_resp_phase();
    axil_master_seq_item req;
    fork
      forever begin  //driving bready
        fork : DRIVE_bready
          begin
            wait(wrresp_phase_q.size() != 0);
            @(posedge vif.drv_cb iff vif.drv_cb.bvalid);
            wrresp_phase_q.delete(0);
            vif.drv_cb.bready <= 1'b1;
	    //if(m_cfg.driver_type_e == PIPELINE_DRV_ENB) 
              seq_item_port.put_response(rsp);
            wr_tx_item_done_ev.trigger();
          end
          begin
            @(negedge vif.drv_cb.bvalid);
            vif.drv_cb.bready <= 1'b0;
          end
        join
        //join_any
        //disable DRIVE_bready;
      end
    join
  endtask : write_resp_phase
  
  //read address channel
  task read_addr_phase();
  
    axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) req;
    trans_type trans_type_e;    

    trans_type_e = NON_SEQ;

    forever begin           //driving Write address channel data
      wait(rdaddr_phase_q.size() != 0);
      if(trans_type_e == NON_SEQ) begin
        @(posedge vif.drv_cb);
      end
      trans_type_e = SEQ;
      req = rdaddr_phase_q.pop_front();
      `uvm_info("READ_REQ_PHASE",$sformatf("read data phase req : %0s ",req.sprint()),UVM_DEBUG)
      vif.drv_cb.arvalid <= 1'b1;
      vif.drv_cb.arid    <= req.arid;
      vif.drv_cb.araddr  <= req.read_start_addr;
      vif.drv_cb.arlen   <= req.rburst_len;   
      vif.drv_cb.arsize  <= $clog2(req.no_of_rbytes);   
      vif.drv_cb.arburst <= req.rburst_type_e; 
      
      //check for ARREADY
     @(posedge vif.drv_cb iff vif.drv_cb.arready);
        begin
          if (rdaddr_phase_q.size == 0) begin 
              trans_type_e = NON_SEQ;
              vif.drv_cb.arvalid <= 0;
            end
        end
      
      rddata_phase_q.push_back(req);
      
    end 
  endtask : read_addr_phase

  
  //read data channel
  task read_data_phase();
    axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) trans_h; 
    fork  
      forever begin  //driving RREADY
        

        fork : DRIVE_RREADY
          begin
              wait(rddata_phase_q.size() != 0);
			        
              @(posedge vif.drv_cb iff vif.drv_cb.rvalid);
              trans_h = axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create("trans_h");  
              vif.drv_cb.rready <= 1'b1;
              trans_h.rid = vif.rid;
              trans_h.read_data_q.push_back(vif.mon_cb.rdata);
              trans_h.rresp = response_e'(vif.mon_cb.rresp);
              `uvm_info("COLLECTED_READ_TRANS",$sformatf("driver read data & rsp : %0s",trans_h.sprint()),UVM_HIGH)
              if (!vif.drv_cb.rlast)
                @(posedge vif.drv_cb.rlast);
              //if(m_cfg.driver_type_e == PIPELINE_DRV_ENB) 
	      seq_item_port.put(rsp);
              rd_tx_item_done_ev.trigger();
          end
          
          begin
            @(negedge vif.drv_cb.rvalid);
            vif.drv_cb.rready <= 1'b0;
          end
        join
        //join_any
        
        //disable DRIVE_RREADY;
      end
    
    join
  endtask : read_data_phase
 
endclass : axil_master_driver

`endif //AXIL_MASTER_DRIVER_SVH

