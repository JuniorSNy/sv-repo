import heap_ops::*;
import pkt_h::*;

module pkt_sche_v0_1 #(
    parameter DWIDTH = 32,
    parameter QUEUE_SIZE = 16
) (
    
    input   logic                                       clk,
    input   logic                                       rst,
    output  logic                                       ready,

    output  logic                                       in_valid,
    input   logic                                       in_enque_en,
    input   logic                                       in_ugr_en,
    input   pkHeadInfo                                  in_pkt_info,
    input   logic [DWIDTH-1:0]                          in_data,
    
    output  logic                                       out_valid,
    input   logic                                       out_deque_en,
    output  logic [DWIDTH-1:0]                          out_data
);
    // reg [31:0]  num_L_q;
    // reg [31:0]  num_R_q;
    // reg [31:0]  num_Out_q;
    // reg         push2Lq;
    logic                   en_among_FIFO;
    logic [DWIDTH-1:0]      addr_among_FIFO;
    logic                   router_ctrl;

    
    logic                   router_in_en;
    logic [DWIDTH-1:0]      router_in_data;
    logic [5:0]             router_in_priority;

    logic                   router_o_0_valid;
    heap_op_t               router_o_0_op_type;
    logic [DWIDTH-1:0]      router_o_0_he_data;
    logic [5:0]             router_o_0_he_priority;

    logic                   router_o_1_valid;
    heap_op_t               router_o_1_op_type;
    logic [DWIDTH-1:0]      router_o_1_he_data;
    logic [5:0]             router_o_1_he_priority;


    logic [DWIDTH-1:0]      BBQ_PQ_0_addr;
    logic [DWIDTH-1:0]      BBQ_PQ_1_addr;

    logic                   BBQ_PQ_0_valid;
    logic                   BBQ_PQ_1_valid;
    logic                   BBQ_PQ_0_rdy;
    logic                   BBQ_PQ_1_rdy;

    heap_op_t               BBQ_out_op;
    heap_op_t               BBQ_PQ_0_optype;
    heap_op_t               BBQ_PQ_1_optype;



    pkt_Priorer #(  ) prior_calculator (
        .clk(clk),
        .rst(rst),
        .in_en(in_enque_en&&(~in_ugr_en)),
        .in_valid(in_valid),
        .in_pkt_info(in_pkt_info),
        .in_data(in_data),

        // .out_deque_en()
        .out_valid(router_in_en),
        .out_data(router_in_data),
        .out_prior(router_in_priority)
    );
    
    always_comb begin
        router_ctrl = 1;
        BBQ_out_op = HEAP_OP_DEQUE_MAX;
    end

    initial ready = 0;
    always @(posedge clk ) begin
        ready <= ready | (BBQ_PQ_0_rdy&&BBQ_PQ_1_rdy);
    end

    BBQ_router #(  ) router (
        .clk(clk),
        .rst(rst),
        
        .bbq_rdy(BBQ_PQ_0_rdy&&BBQ_PQ_1_rdy),

        .in_enque_en(router_in_en),
        .in_data(router_in_data),
        .in_prior(router_in_priority),

        .out_ctrl(router_ctrl),
        .out_op(BBQ_out_op),

        .out_0_valid(router_o_0_valid),
        .out_0_op_type(router_o_0_op_type),
        .out_0_he_data(router_o_0_he_data),
        .out_0_he_priority(router_o_0_he_priority),

        .out_1_valid(router_o_1_valid),
        .out_1_op_type(router_o_1_op_type),
        .out_1_he_data(router_o_1_he_data),
        .out_1_he_priority(router_o_1_he_priority)
    );

    bbq  #(
//        .HEAP_ENTRY_DWIDTH(DWIDTH)
    ) BBQ_PQ_0 (
        .clk(clk),
        .rst(rst),
        .ready(BBQ_PQ_0_rdy),
        .in_valid(router_o_0_valid),
        .in_op_type(router_o_0_op_type),
        .in_he_data(router_o_0_he_data),
        .in_he_priority(router_o_0_he_priority),
        .out_valid(BBQ_PQ_0_valid),
        .out_op_type(BBQ_PQ_0_optype),
        .out_he_data(BBQ_PQ_0_addr),
        .out_he_priority()
    );

    bbq  #(
//        .HEAP_ENTRY_DWIDTH(DWIDTH)
        ) BBQ_PQ_1 (
        .clk(clk),
        .rst(rst),
        .ready(BBQ_PQ_1_rdy),
        .in_valid(router_o_1_valid),
        .in_op_type(router_o_1_op_type),
        .in_he_data(router_o_1_he_data),
        .in_he_priority(router_o_1_he_priority),
        .out_valid(BBQ_PQ_1_valid),
        .out_op_type(BBQ_PQ_1_optype),
        .out_he_data(BBQ_PQ_1_addr),
        .out_he_priority()
    );

    FIFOdual  #(
        .DWIDTH(DWIDTH),
        .QUEUE_SIZE(QUEUE_SIZE)
    ) out_buffer (
        .clk(clk),
        .rst(rst),
        .in_valid(),
        .inA_enque_en( (BBQ_PQ_0_optype==BBQ_out_op)?BBQ_PQ_0_valid:0 ),
        .inB_enque_en( (BBQ_PQ_1_optype==BBQ_out_op)?BBQ_PQ_1_valid:0 ),
        .inA_data( BBQ_PQ_0_addr ),
        .inB_data( BBQ_PQ_1_addr ),
        .out_deque_en(1'b1),
        .out_valid(en_among_FIFO),
        .out_data(addr_among_FIFO)

    );

    FIFOdual  #(
        .DWIDTH(DWIDTH),
        .QUEUE_SIZE(QUEUE_SIZE)
    ) out_Ugr_buffer (
        .clk(clk),
        .rst(rst),
        .in_valid(),
        .inA_enque_en( in_ugr_en&&in_enque_en ),
        .inB_enque_en( en_among_FIFO ),
        .inA_data(in_data),
        .inB_data(addr_among_FIFO),
        .out_deque_en(out_deque_en),
        .out_valid(out_valid),
        .out_data(out_data)
    );


    // always_comb begin
    // end
    // always @(posedge clk or posedge rst) begin
    //     if (rst) begin
    //     end else begin
    //     end
    // end


    
endmodule