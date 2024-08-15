`timescale 1 ns/10 ps
import heap_ops::*;
import pkt_h::*;
import heap_ops::*;

module tb_pkt_sche_v0_1;

// Simulation parameters. Some testcases implicitly depend
// on the values being set here, so they musn't be changed!

logic clk,rst,pkt_ready,in_valid,in_enque_en,in_ugr_en,out_valid,out_deque_en;
logic [pkt_sche_v0_1_inst.DWIDTH-1:0] in_data,out_data;
int counter;
pkHeadInfo                                  in_pkt_info;
 
initial rst = 1;
initial clk = 0;
initial counter = 0;
initial out_deque_en = 1;
//initial in_data = 0;
//initial in_enque_en = 0;
//initial in_pkt_info = 0;
//initial in_ugr_en = 0;

always_comb begin

        in_data = pkt_ready?counter+32'h114:0;
        in_enque_en = pkt_ready;
        in_pkt_info = pkt_ready?(counter%4 + 32'h114514):0;
        in_ugr_en = ((counter%10==9||counter%10==0)&(pkt_ready))?1:0;
end
always #(10) clk = ~clk;
always @( posedge clk ) begin
    rst <= 0;
    if (pkt_ready) begin
        counter <= counter+1;
//        in_data <= counter;
//        in_enque_en <= pkt_ready;
//        in_pkt_info <= counter%4 + 32'h114514;
//        in_ugr_en <= (counter%10==9)?1:0;
        $write("in_pkt_info = %x; in_data = %x\n",in_pkt_info,in_data);
        if(counter>64)begin
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
    .in_pkt_info(in_pkt_info),
    .in_data(in_data),

    .out_valid(out_valid),
    .out_deque_en(out_deque_en),
    .out_data(out_data)
);

endmodule
