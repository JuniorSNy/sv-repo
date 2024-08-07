import pkt_h::*;
`timescale 1 ns/10 ps

module pkt_Priorer_tb;

logic clk;
logic rst;
int i;
// logic init_done;
// initial counter = 0;
// initial init_done = 0;
// initial test_timer = 0;
logic pkt_in_en;
logic pkt_in_valid;
pkHeadInfo pkt_in_info;
logic [pkt_Priorer_inst.DWIDTH-1:0] pkt_in_data,pkt_out_data;
logic [pkt_Priorer_inst.PRIOR_WIDTH-1:0] pkt_out_prior;
logic pkt_out_valid;



initial clk = 0;
initial rst = 1;
initial i = 0;
initial pkt_in_en = 0;
always #(10) clk = ~clk;

always @(posedge clk) begin
    rst <= 0;
    pkt_in_en <= 1;
    i=i+1;

    pkt_in_info.key <= i%7 + 1;
    pkt_in_data <= $random();
    // o_fifo_data <= {$random(),$random(),$random(),$random(),$random(),$random(),$random(),$random()};
    // test_timer <= test_timer + 1;
    // in_data_addr <= $random();

    // if (test_timer) begin
    //     if (in_valid==1'b0) begin
    //         in_enque_en = 1'b0;
    //         out_deque_en = 1'b1;
    //     end
    //     if (test_timer > 30) begin
    //         $display("testbench init timed out");
    //         $finish;
    //     end
    // end
end


pkt_Priorer #(
    // .DWIDTH(64),
    // .QUEUE_SIZE(21)
) pkt_Priorer_inst (
    .clk(clk),
    .rst(rst),
    .in_en(pkt_in_en),
    .in_valid(pkt_in_valid),
    .in_pkt_info(pkt_in_info),
    .in_data(pkt_in_data),
    .out_valid(pkt_out_valid),
    .out_data(pkt_out_data),
    .out_prior(pkt_out_prior)
);

endmodule