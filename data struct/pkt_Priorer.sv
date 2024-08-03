import pkt_h::*;

module pkt_Priorer #(
    parameter DWIDTH = 32,
    parameter SLOT_SIZE = 8

) (
    input   logic                                       clk,
    input   logic                                       rst,

    input   logic                                       in_en,
    output  logic                                       in_valid,
    input   pkHeadInfo                                  in_pkt_info,
    output  logic [DWIDTH-1:0]                          in_data,
    
    input   logic                                       out_deque_en,
    output  logic                                       out_valid,
    output  logic [DWIDTH-1:0]                          out_data,
    output  logic [5:0]                                 out_prior
);

    
    // reg [31:0]  num_L_q;
    // reg [31:0]  num_R_q;
    // reg [31:0]  num_Out_q;
    // reg         push2Lq;
    pkHeadInfo         o_fifo_data;
//    logic           out_valid;
//    logic           out_deque_en;


    FIFOdual #( .DWIDTH(16'd96) ) EntryCollector (
        // General I/O
        .clk(clk),
        .rst(rst),

        .inA_enque_en(in_en),//get pkt info from module input
        .inA_data({in_pkt_info.sIP,in_pkt_info.dIP,in_pkt_info.sPort,in_pkt_info.dPort}),

        .inB_enque_en(0),
        .inB_data(0),

        .in_valid(in_valid),

        .out_deque_en(out_deque_en),
        .out_valid(out_valid),
        .out_data({o_fifo_data.sIP,o_fifo_data.dIP,o_fifo_data.sPort,o_fifo_data.dPort})
    );


    QuadSet CompQueq [SLOT_SIZE-1:0];
    QuadSet CompSlot [SLOT_SIZE-1:0];
    logic   CompRslt [SLOT_SIZE-1:0];
    
    integer i,j;

    always_comb begin
        for(int i=0;i<SLOT_SIZE;i++) begin
            CompRslt[i] = 1'b1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for(int i=0;i<SLOT_SIZE;i++) begin
                CompQueq[i] <= 0;
                CompSlot[i] <= 0;
            end
        end else begin

            CompQueq[0] <= (out_valid)?o_fifo_data:0 ;

            for(int j=1;j<SLOT_SIZE;j++) begin
                CompQueq[j] <= CompQueq[j-1];
                CompSlot[i] <= CompQueq[i];
            end

            out_prior <= CompQueq[SLOT_SIZE-1].NoF;
        end
    end


    
endmodule