/////  configurable_class /////

`ifndef AXIL_ENV_CONFIG
`define AXIL_ENV_CONFIG

class axil_env_config extends uvm_object;

	`uvm_object_utils(axil_env_config)
	
	virtual axil_if axil_vif;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	int verbosity;

	function new(string name = "axil_env_config");
  	super.new(name);
	endfunction

endclass : axil_env_config

`endif //AXIL_ENV_CONFIG
