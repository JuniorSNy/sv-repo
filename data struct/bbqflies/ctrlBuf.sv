import heap_ops::*;
import BBQctrl::*;
// `define DEBUG

module ctrlBuf #(
    parameter BUFF_ENTRY_DWIDTH = 32,
    parameter OUT_BUFF_SIZE = 16
) (
    // General I/O
    input   logic                                       clk,
    input   logic                                       rst,

    input   logic                                       in_enque_en,
    output  logic                                       in_valid,
    input   logic [BUFF_ENTRY_DWIDTH-1:0]               in_buff_addr,
    
    input   logic                                       out_deque_en,
    output  logic                                       out_valid,
    output  logic [BUFF_ENTRY_DWIDTH-1:0]               out_buff_addr
);
    // alterState BBQchoice;
    logic [63:0] counter;
    logic [BUFF_ENTRY_DWIDTH-1:0] OutBuff[OUT_BUFF_SIZE-1:0];
    logic [$clog2(OUT_BUFF_SIZE)-1:0] OutBuffHead;
    logic [$clog2(OUT_BUFF_SIZE)-1:0] OutBuffTail;
    logic [$clog2(OUT_BUFF_SIZE)-1:0] nextTail ;
    logic [$clog2(OUT_BUFF_SIZE)-1:0] nextHead ;
    

    always_comb begin
        nextTail = (OutBuffTail+1'b1)%OUT_BUFF_SIZE;
        nextHead = (OutBuffHead+1'b1)%OUT_BUFF_SIZE;
        out_valid = (( OutBuffHead == ( OutBuffTail )) ?1'b0:1'b1);
        in_valid  = (( nextTail == (OutBuffHead)) ?1'b0:1'b1);
        out_buff_addr = OutBuff[OutBuffHead];
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            OutBuffHead <= 0;
            OutBuffTail <= 0;
            for (int i=0; i<OUT_BUFF_SIZE; ++i) begin
                OutBuff[i] <= 0;
            end
        end else begin
            counter <= counter+1;
            if ( in_enque_en && in_valid ) begin
                OutBuff[OutBuffTail] <= in_buff_addr;
                OutBuffTail <= (OutBuffTail + 1)%OUT_BUFF_SIZE;
            end
            if ( out_deque_en && out_valid ) begin
                OutBuffHead <= (OutBuffHead + 1)%OUT_BUFF_SIZE;
            end
        end
    end
endmodule