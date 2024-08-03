module moduleName #(
    parameter DWIDTH = 32,
    parameter QUEUE_SIZE = 16
) (
    
    input   logic                                       clk,
    input   logic                                       rst,

    input   logic                                       in_en,
    output  logic                                       in_valid,
    input   pkHeadInfo                                  in_pkt_info,
    output  logic [DWIDTH-1:0]                          in_data,
    
    input   logic                                       out_deque_en,
    output  logic                                       out_valid,
    output  logic [DWIDTH-1:0]                          out_data
);


    pkt_Priorer #() prior_calculator ();



    reg [31:0]  num_L_q;
    reg [31:0]  num_R_q;
    reg [31:0]  num_Out_q;
    reg         push2Lq;

    bbq  #() L_buff_PQ ();
    bbq  #() R_buff_PQ ();
    FIFO  #() out_buffer ();


    always_comb begin
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
        end else begin
        end
    end


    
endmodule