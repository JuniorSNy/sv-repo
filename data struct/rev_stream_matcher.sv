
// `define DEBUG

module rev_stream_matcher #(
    parameter REV_SIZE = 32,
    parameter MatchER_SIZE = 32,
    parameter KWIDTH = 16,//KEY_SIZE
    parameter DWIDTH = 16,
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
    typedef struct packed {
        logic [KWIDTH-1:0] Key;
        logic [DWIDTH-1:0] Data;
        logic valid;
        logic [2:0] lastmatch;

    } matcher_t;

    // alterState BBQchoice;

    matcher_t [MatchER_SIZE-1:0] matcherGroup;



    

    always_comb begin

    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin

        end else begin
            
        end
    end
endmodule