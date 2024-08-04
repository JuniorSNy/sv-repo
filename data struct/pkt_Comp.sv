import pkt_h::*;

module pkt_Comp #(
    parameter DWIDTH = 32,
    parameter SLOT_SIZE = 8

) (
    input   logic                                       clk,
    input   logic                                       rst,

    input   logic                                       in_en,
    output  logic                                       in_valid,
    input   pkHeadInfo                                  in_pkt_info,
    input   logic [DWIDTH-1:0]                          in_data,
    
    input   logic                                       out_deque_en,
    output  logic                                       out_valid,
    output  logic [DWIDTH-1:0]                          out_data,
    output  logic [5:0]                                 out_prior
);

endmodule