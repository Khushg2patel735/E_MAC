/////  configurable_class /////

`ifndef AXIL_MAS_CONFIG
`define AXIL_MAS_CONFIG
typedef enum bit { PIPELINE_DRV_ENB, PIPELINE_DRV_DISENB} driver_type;
class axil_mas_config extends uvm_object;


	
	virtual axil_if axil_vif;

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	driver_type driver_type_e =   PIPELINE_DRV_DISENB;
	
	int id;

	int verbosity;

	`uvm_object_utils_begin(axil_mas_config)
	    `uvm_field_int(id, UVM_ALL_ON | UVM_DEC)
	    `uvm_field_int(verbosity, UVM_ALL_ON | UVM_DEC)
	    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON | UVM_STRING)
	    `uvm_field_enum(driver_type, driver_type_e, UVM_ALL_ON | UVM_STRING)
	`uvm_object_utils_end

	function new(string name = "axil_mas_config");
  	super.new(name);
	endfunction

endclass : axil_mas_config

`endif //AXIL_CONFIG
