module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16
)(
    input clk,rst,rd_en,wr_en,
    input      [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout,
    output full,empty
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    // Extra bit is used for full/empty detection
    reg [ADDR_WIDTH:0] rd_ptr;
    reg [ADDR_WIDTH:0] wr_ptr;

    reg [DATA_WIDTH-1:0] fifo [0:DEPTH-1];

    // Simultaneous read conditions
    wire simult_rw_when_full = full && rd_en && wr_en;
    // simultabeous write condition
    wire simult_rw_when_empty = empty && rd_en && wr_en;
  
    // Allow read/write
    wire wr_allowed = (!full) || simult_rw_when_full;
    wire rd_allowed = (!empty) || simult_rw_when_empty;
   
    // FIFO operation
    always @(posedge clk) begin
     if (rst) begin
            dout   <= {DATA_WIDTH{1'b0}};
            rd_ptr <= {(ADDR_WIDTH+1){1'b0}};
            wr_ptr <= {(ADDR_WIDTH+1){1'b0}};
     end

      else begin
        if (rd_en && rd_allowed ) begin  //rd operation
                rd_ptr <= rd_ptr + 1'b1;
                if (simult_rw_when_empty || simult_rw_when_full)
                    dout <= din;
                else
                    dout <= fifo[rd_ptr[ADDR_WIDTH-1:0]];
            end
          
          if (wr_en && wr_allowed) begin   //write opration
                fifo[wr_ptr[ADDR_WIDTH-1:0]] <= din;
                wr_ptr <= wr_ptr + 1'b1;
          end
      end
  end
  
  assign empty = (rd_ptr == wr_ptr);  // empty condition
  assign full  = (rd_ptr == {~wr_ptr[ADDR_WIDTH],wr_ptr[ADDR_WIDTH-1:0]});  // full condition 

endmodule
