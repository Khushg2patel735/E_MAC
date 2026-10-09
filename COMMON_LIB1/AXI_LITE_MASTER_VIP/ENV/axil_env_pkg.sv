`ifndef AXIL_ENV_PKG_SV
`define AXIL_ENV_PKG_SV

  
package axil_env_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
 
  int no_itr=3;

  import axil_master_pkg::*;
  
  `include "axil_defines.sv"
  `include "axil_env_config.sv"
  `include "axil_env.sv"

endpackage 
	
`endif //AXIL_ENV_PKG_SV
