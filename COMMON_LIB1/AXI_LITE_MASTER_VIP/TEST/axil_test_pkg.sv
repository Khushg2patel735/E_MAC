`ifndef AXIL_TEST_PKG_SV
`define AXIL_TEST_PKG_SV

package axil_test_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	typedef virtual axil_if axil_vif;
  
  import axil_master_pkg::*;
  import axil_env_pkg::*;
  
  //`include "axi_env.sv"

  `include "axil_defines.sv"
  
 // `include "axil_config.sv"

	`include "axil_base_test.sv"
    
endpackage 
	
`endif //AXIL_TEST_PKG_SV
