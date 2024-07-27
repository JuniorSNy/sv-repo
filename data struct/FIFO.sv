
// `define DEBUG

module FIFO #(
    parameter DWIDTH = 32,
    parameter QUEUE_SIZE = 16
) (
    // General I/O
    input   logic                                       clk,
    input   logic                                       rst,

    input   logic                                       in_enque_en,
    output  logic                                       in_valid,
    input   logic [DWIDTH-1:0]                          in_data,
    
    input   logic                                       out_deque_en,
    output  logic                                       out_valid,
    output  logic [DWIDTH-1:0]                          out_data
);
    // alterState BBQchoice;
    logic [63:0] counter;
    logic [DWIDTH-1:0] OutBuff[QUEUE_SIZE-1:0];
    logic [$clog2(QUEUE_SIZE)-1:0] OutBuffHead;
    logic [$clog2(QUEUE_SIZE)-1:0] OutBuffTail;
    logic [$clog2(QUEUE_SIZE)-1:0] nextTail ;
    logic [$clog2(QUEUE_SIZE)-1:0] nextHead ;
    

    always_comb begin
        nextTail = (OutBuffTail+1'b1)%QUEUE_SIZE;
        nextHead = (OutBuffHead+1'b1)%QUEUE_SIZE;
        out_valid = (( OutBuffHead == ( OutBuffTail )) ?1'b0:1'b1);
        in_valid  = (( nextTail == (OutBuffHead)) ?1'b0:1'b1);
        out_data = OutBuff[OutBuffHead];
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            OutBuffHead <= 0;
            OutBuffTail <= 0;
            for (int i=0; i<QUEUE_SIZE; ++i) begin
                OutBuff[i] <= 0;
            end
        end else begin
            counter <= counter+1;
            if ( in_enque_en && in_valid ) begin
                OutBuff[OutBuffTail] <= in_data;
                OutBuffTail <= nextTail;
            end
            if ( out_deque_en && out_valid ) begin
                OutBuffHead <= nextHead;
            end
        end
    end
endmodule