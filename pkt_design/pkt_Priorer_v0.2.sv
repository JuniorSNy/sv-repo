import pkt_h::*;



module pkt_Priorer_v0_2 #(
    parameter DWIDTH = 32,
    parameter SLOT_SIZE = 8,
    parameter SLOT_WIDTH = 8,
    parameter QUEUE_SIZE = 16,
    parameter PRIOR_WIDTH = 6,
    parameter SET = 2
) (
    input   logic                                       clk,
    input   logic                                       rst,
    // Data & PktInfo for priority caculation
    input   logic                                       in_en,
    output  logic                                       in_valid,
    input   pkHeadInfo                                  in_pkt_info,
    input   logic [DWIDTH-1:0]                          in_data,
    // Outdata & priority, data and priority enabled when valid==1'b1, if 
    output  logic                                       out_valid,
    output  logic [DWIDTH-1:0]                          out_data,
    output  logic [PRIOR_WIDTH-1:0]                     out_prior
);

    // logic [5:0] KeyHash;
    pkHeadInfo datapipeline [SLOT_SIZE:0];
    RecordSpot recordStack  [SLOT_SIZE-1:0][SLOT_SIZE-1:0];
    
    logic match [SLOT_SIZE-1:0];
    int matchNum [SLOT_SIZE-1:0];

    logic empty [SLOT_SIZE-1:0];
    int emptyNum [SLOT_SIZE-1:0];
    
    int LRU_Num [SLOT_SIZE-1:0];

    always_comb begin
        for(int i=0;i<SLOT_SIZE;i++)begin
            empty[i] = 0;
            emptyNum[i] = 0;
            for(int j=0;j<SLOT_SIZE;j++)begin
                if(recordStack[i][j].valid == 0)begin
                    empty[i] = 1;
                    emptyNum[i] = j+1;
                end
            end
        end
    end


    Ringslot    FIFO_pkt_in_set;
    Ringslot    FIFO_out_set;
    always_comb begin
        FIFO_pkt_in_set.valid               = 1'b1;
        FIFO_pkt_in_set.NoF                 = 0;
        FIFO_pkt_in_set.MatchFail           = 0;
        FIFO_pkt_in_set.Info                = in_pkt_info;

        // out_prior   = Comp_in_set[SLOT_SIZE-1].NoF;
        // out_data    = Comp_in_data[SLOT_SIZE-1];
        // out_valid   = (Comp_in_set[SLOT_SIZE-1].NoF!=0)&&(Comp_in_set[SLOT_SIZE-1].valid==1);
        // out_fail    = (Comp_in_set[SLOT_SIZE-1].NoF==0)&&(Comp_in_set[SLOT_SIZE-1].valid==1);
        
    end

    FIFOdual #( .DWIDTH( $bits(FIFO_pkt_in_set)+$bits(in_data) ) ) EntryCollector (
        .clk(clk),
        .rst(rst),

        .in_valid(in_valid),
        .inA_enque_en(in_en),
        .inA_data({FIFO_pkt_in_set,in_data}),
        .inB_enque_en(out_fail),
        .inB_data({Comp_in_set[SLOT_SIZE],Comp_in_data[SLOT_SIZE]}),

        .out_deque_en(1'b1),
        .out_valid(F_out_valid),
        .out_data({FIFO_out_set,FIFO_out_data})
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            recordStack <= 0;
            datapipeline <= 0;
        end else begin
            
            
            
            
            
            
            
            
            
            
        end
    end
endmodule