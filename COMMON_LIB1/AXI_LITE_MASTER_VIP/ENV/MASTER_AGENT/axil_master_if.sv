

`ifndef AXIL_MASTER_IF_SV
`define AXIL_MASTER_IF_SV
`include "axil_defines.sv"
interface axil_master_if(input bit aclk);

  parameter ADDR_SIZE=32,
            DATA_SIZE=32,
            ID_SIZE=32,
	    in_skew=2ns,
	    out_skew=2ns;

  //----------------- Global signals -----------------
  //logic aclk; //TODO 
  logic ARESETn;

  //-----------------Write Address Channel -----------------
  logic [(ID_SIZE-1):0] awid;					//Write address ID
  logic [(ADDR_SIZE-1):0] awaddr;     //Write address
  logic [7:0] awlen;                    //Burst length
  logic [2:0] awsize;                   //Burst size
  logic [1:0] awburst;                  //Burst type
  logic awvalid;                        //Write address valid
  logic awready=1'b1;                        //Write address ready     slave to Master //TODO
  
  //-----------------Write Data Channel --------------------
  logic [(ID_SIZE-1):0] wid;          //Write data ID
  logic [(DATA_SIZE-1):0] wdata;      //Write data
  logic [((DATA_SIZE/8)-1):0] wstrb;      //Write strobes
  logic wlast;                          //Write last
  logic wvalid;                         //Write valid
  logic wready=1'b1;                         //Write ready             slave to master //TODO
	
  //-----------------Write Response Channel ----------------- 
  logic [(ID_SIZE-1):0] bid=15;          //Response ID
  logic [1:0] bresp=0;                    //Write response(response_e)
  logic bvalid=1'b1;                         //Write response
  logic bready;                         //Response ready          master to slave
  
  //-----------------Read Address Channel -----------------
	logic [(ID_SIZE-1):0] arid;					//Read address ID
  logic [(ADDR_SIZE-1):0] araddr;     //rEAD ADDRESS
  logic [7:0] arlen;                    //Burst length
  logic [2:0] arsize;                   //Burst size
  logic [1:0] arburst;                  //Burst type
  logic [1:0] arprot;                   //Protection type
  logic [3:0] ARREGION;                  //Write region */
  logic arvalid;                        //Read address valid
  logic arready=1'b1;                        //Read address ready    slave to master //TODO
  
  //-----------------Read Data Channel -------------------- 
  logic [(ID_SIZE-1):0] rid;          //Read data ID
  logic [(DATA_SIZE-1):0] rdata;      //Read data
  logic [1:0] rresp;                    //Read response (response_e) 
  logic rlast;                          //Read last
  logic rvalid;                         //Read valid
  logic rready=1'b1;                         //Read ready          master to slave
  
  clocking drv_cb @(posedge aclk);
    default input #(`axil_mas_i_skew) output #(`axil_mas_o_skew);
    output awvalid,awsize,awlen,awburst,awid,awaddr;
    output wvalid,wid,wdata,wstrb,wlast;
    output bready;
    output arvalid,arsize,arlen,arburst,arid,araddr;
    output rready;
    input awready,wready,bvalid,arready,rvalid,bid,bresp,rid,rdata,rresp,rlast;
  endclocking

  clocking mon_cb @(posedge aclk);
    default input #(`axil_mas_i_skew) output #(`axil_mas_o_skew);
    input awvalid,awready,awsize,awlen,awburst,awid,awaddr;
    input wvalid,wready,wid,wdata,wstrb,wlast;
    input bready,bvalid,bid,bresp;
    input arvalid,arready,arsize,arlen,arburst,arid,araddr;
    input rready,rvalid,rid,rdata,rresp,rlast;
  endclocking 
endinterface: axil_master_if

`endif       //AXIL_MASTER_IF_SV
