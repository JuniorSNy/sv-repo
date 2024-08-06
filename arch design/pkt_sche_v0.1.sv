module moduleName #(
    parameter DWIDTH = 32,
    parameter QUEUE_SIZE = 16
) (
    
    input   logic                                       clk,
    input   logic                                       rst,

    output  logic                                       in_valid,
    input   logic                                       in_enque_en,
    input   logic                                       in_Ugr_en,
    input   pkHeadInfo                                  in_pkt_info,
    input   logic [DWIDTH-1:0]                          in_data,
    
    output  logic                                       out_valid,
    input   logic                                       out_deque_en,
    output  logic [DWIDTH-1:0]                          out_data
);


    reg [31:0]  num_L_q;
    reg [31:0]  num_R_q;
    reg [31:0]  num_Out_q;
    reg         push2Lq;


    pkt_Priorer #(

    ) prior_calculator ();

    BBQ_router #(

    ) router ();

    bbq  #(

    ) L_buff_PQ ();

    bbq  #(

    ) R_buff_PQ ();

    FIFOdual  #(

    ) out_buffer ();

    FIFOdual  #(

    ) out_Ugr_buffer ();


    always_comb begin
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
        end else begin
        end
    end


    
endmodule