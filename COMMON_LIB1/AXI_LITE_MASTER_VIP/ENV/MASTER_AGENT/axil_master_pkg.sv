`ifndef AXIL_MAS_PKG_SV
`define AXIL_MAS_PKG_SV

`include "axil_master_if.sv"  
package axil_master_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
 
   typedef virtual axil_master_if vif;
  `include "axil_master_config.sv"
  `include "axil_master_defines.sv"
  
  
  // axil Master Files
  `include "axil_master_seq_item.sv"
  `include "axil_master_sequencer.sv"
  `include "axil_master_driver.sv"
  `include "axil_master_monitor.sv"
  `include "axil_master_agent.sv"
  `include "axil_master_base_sequence.sv"
  
endpackage 
	
`endif //AXIL_MAS_PKG_SV
