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
    input   logic [DWIDTH-1:0]                          in_data,
    
    input   logic                                       out_deque_en,
    output  logic                                       out_valid,
    output  logic [DWIDTH-1:0]                          out_data,
    output  logic [5:0]                                 out_prior
);

    
    // reg [31:0]  num_L_q;
    // reg [31:0]  num_R_q;
    // reg [31:0]  num_Out_q;
    // reg         push2Lq;
    pkHeadInfo          o_fifo_info;
    pkHeadInfo          o_fail_info;
    logic [DWIDTH-1:0]  o_fail_data;
    logic [DWIDTH-1:0]  o_fifo_data;
    logic               out_fail;

    pkHeadInfo CompQueq [SLOT_SIZE-1:0];
    pkHeadInfo CompSlot [SLOT_SIZE-1:0];
    logic [DWIDTH-1:0]  Data_slot [SLOT_SIZE-1:0];
    logic [5:0]  NoF_slot [SLOT_SIZE-1:0];
    logic   CompRslt [SLOT_SIZE-1:0];
    logic   F_out_valid;
    logic [5:0]  NoF_out;
    logic [5:0]  o_fail_NoF;
    
    integer i,j;


    FIFOdual #( .DWIDTH($bits(in_pkt_info)+$bits(in_data)+6) ) EntryCollector (
        // General I/O
        .clk(clk),
        .rst(rst),

        .inA_enque_en(in_en),
        .inA_data({in_pkt_info,in_data,6'b0}),

        .inB_enque_en(out_fail),
        .inB_data({o_fail_info, o_fail_data, NoF_slot[SLOT_SIZE-1]}),

        .in_valid(in_valid),

        .out_deque_en(1'b1),
        .out_valid(F_out_valid),
        .out_data({o_fifo_info,o_fifo_data,NoF_out})
    );



    always_comb begin
        out_prior   = NoF_slot[SLOT_SIZE-1];
        out_data    = Data_slot[SLOT_SIZE-1];
        out_valid   = (NoF_slot[SLOT_SIZE-1]!=0)&&(CompQueq[SLOT_SIZE-1].valid==1);
        
        out_fail    = (NoF_slot[SLOT_SIZE-1]==0)&&(CompQueq[SLOT_SIZE-1].valid==1);
        o_fail_info = CompQueq[SLOT_SIZE-1];
        o_fail_data = Data_slot[SLOT_SIZE-1];
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for(int i=0;i<SLOT_SIZE;i++) begin
                CompQueq[i] <= 0;
                CompSlot[i] <= 0;
                Data_slot[i] <= 0;
                NoF_slot[i]  <= 0;
            end
        end else begin

            CompQueq[0] <= (F_out_valid)?o_fifo_info:0 ;
            CompQueq[0].valid <= F_out_valid;
            Data_slot[0] <= (F_out_valid)?o_fifo_data:0 ;
            NoF_slot[0]  <= (F_out_valid)?NoF_out:0;

            // CompQueq[j] <= CompQueq[j-1];
            // CompQueq[j].NoF <= j;
            // Data_slot[j] <= Data_slot[j-1];

            
            for(int i=1;i<SLOT_SIZE;i++) begin
                CompQueq[i] <= CompQueq[i-1];
                // CompSlot[i] <= 0;
                Data_slot[i] <= Data_slot[i-1];
            end


            for(int i=1;i<SLOT_SIZE;i++) begin
                
                NoF_slot[i]  <= NoF_slot[i-1] ;

                if( (CompSlot[j-1].valid==0) && (CompQueq[j-1].valid==1)  ) begin
                    if((CompQueq[j-1].NoF==0)) begin
                        // CompSlot[j-1] <= CompQueq[j-1];
                        // CompSlot[j-1].valid <= 1'b1;
                        // CompQueq[j] <= CompQueq[j-1];
                        // CompQueq[j].NoF <= j;
                        // Data_slot[j] <= Data_slot[j-1];
                    end else begin
                        // CompSlot[j-1] <= CompQueq[j-1];
                        // CompSlot[j-1].valid <= 1'b1;
                        // CompQueq[j] <= CompQueq[j-1];
                        // CompQueq[j].NoF <= j;
                        // Data_slot[j] <= Data_slot[j-1];
                    end
                end
                    
                // end else if ( (CompSlot[j-1].valid==1) && (CompQueq[j-1].valid==1) && (CompQueq[j-1].NoF==0)) begin
                //     if( (CompSlot[j-1].sIP==CompQueq[j-1].sIP)  &&
                //         (CompSlot[j-1].dIP==CompQueq[j-1].dIP)  &&
                //         (CompSlot[j-1].sPort==CompQueq[j-1].sPort) &&
                //         (CompSlot[j-1].dPort==CompQueq[j-1].dPort) ) begin

                //             // CompSlot[j-1] <= CompQueq[j-1];
                //             // CompSlot[j-1].valid <= 1'b1;
                //             CompQueq[j] <= CompQueq[j-1];
                //             CompQueq[j].NoF <= j;
                //             Data_slot[j] <= Data_slot[j-1];
                        
                //         end else begin
                        
                //             // CompSlot[j-1] <= CompQueq[j-1];
                //             // CompSlot[j-1].valid <= 1'b1;
                //             CompQueq[j] <= CompQueq[j-1];
                //             CompQueq[j].NoF <= j;
                //             Data_slot[j] <= Data_slot[j-1];
                        
                //         end
                    
                // end else begin
                //     CompQueq[j] <= CompQueq[j-1];
                //     CompQueq[j].NoF <= j;
                //     Data_slot[j] <= Data_slot[j-1];
                    
                // end
            end


        end
    end


    
endmodule