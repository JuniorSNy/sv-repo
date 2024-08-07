`timescale 1 ns/10 ps

import heap_ops::*;

module tb_pkt_sche_v0_1;

// Simulation parameters. Some testcases implicitly depend
// on the values being set here, so they musn't be changed!

logic clk,rst,pkt_ready,in_valid,in_enque_en,in_ugr_en,out_valid,out_deque_en;
logic [pkt_sche_v0_1_inst.DWIDTH-1:0] in_data,out_data;
int counter;
initial rst = 1;
initial clk = 0;
initial in_data = 0;
initial in_enque_en = 0;
initial in_ugr_en = 0;
initial counter = 0;

always #(10) clk = ~clk;
always @( posedge clk ) begin
    rst <= 0;
    if (pkt_ready) begin
        counter <= counter+1;
        if(counter>10)begin
            $stop;
        end
    end
end

// BBQ instance
pkt_sche_v0_1 #() pkt_sche_v0_1_inst (
    .clk(clk),
    .rst(rst),
    .ready(pkt_ready),
    
    .in_valid(in_valid),
    .in_enque_en(in_enque_en),
    .in_ugr_en(in_ugr_en),
    .in_pkt_info(0),
    .in_data(in_data),

    .out_valid(out_valid),
    .out_deque_en(out_deque_en),
    .out_data(out_data)
);

endmodule
