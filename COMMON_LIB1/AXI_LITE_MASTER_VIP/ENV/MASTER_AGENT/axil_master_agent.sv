

`ifndef AXIL_MASTER_AGENT_SVH
`define AXIL_MASTER_AGENT_SVH

class axil_master_agent #(shortint ADDR_SIZE=32,DATA_SIZE=32,ID_SIZE=32) extends uvm_agent;
	
	int index;
	
	//component of agent
  axil_master_sequencer #(ADDR_SIZE,DATA_SIZE,ID_SIZE) master_sequencer;
	axil_master_driver	   #(ADDR_SIZE,DATA_SIZE,ID_SIZE) master_driver;
	axil_master_monitor	 #(ADDR_SIZE,DATA_SIZE,ID_SIZE) master_monitor;

        virtual axil_master_if vif;

  //axi_cfg instance for make a environment configurable 
	axil_mas_config axil_mcfg;
	
	//provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(axil_master_agent)
	
	//new - constructor
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction	: new 
	
	function void set_index (int index);
		this.index = index;
	endfunction: set_index
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
                 if (!uvm_config_db #(virtual axil_master_if)::get(this, "","vif",vif))
			`uvm_fatal(get_full_name(),{"virtual interface must be set for : ", get_full_name(),".vif"})

 		if (!uvm_config_db #(axil_mas_config)::get(this,"*","axi_mcfg",axil_mcfg))
			`uvm_fatal("CONFIG_FAIL","Not able to get master config") 
		 if (axil_mcfg.is_active == UVM_ACTIVE) begin ;
			master_driver = axil_master_driver #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create("master_driver",this);
			master_sequencer = axil_master_sequencer #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create("master_sequencer",this);
		 end
		master_monitor = axil_master_monitor #(ADDR_SIZE,DATA_SIZE,ID_SIZE) ::type_id::create("master_monitor",this);
	endfunction: build_phase
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		 if (axil_mcfg.is_active == UVM_ACTIVE) begin
		master_driver.seq_item_port.connect(master_sequencer.seq_item_export);
                 master_driver.vif =  vif;
		 master_driver.m_cfg = axil_mcfg;
		end 
                master_monitor.vif = vif;
	endfunction : connect_phase
	
endclass : axil_master_agent

`endif //AXIL_MASTER_AGENT_SVH
				
