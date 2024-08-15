module pktdemo(
    port_list
);
    

    logic match [SLOT_SIZE-1:0];
    logic[$clog(SLOT_SIZE)-1:0] matchNum [SLOT_SIZE-1:0];
    logic recordStack [SLOT_SIZE-1:0][SLOT_SIZE-1:0];

    initial recordStack = %random();
    
    always_comb begin
        // KeyHash = in_pkt_info.key[8:3];
        match = 0;
        matchNum = 0;
        for(int i=0;i<SLOT_SIZE;i++)begin
            for (int j=0; j<SLOT_SIZE; ++j) begin
                if(recordStack[i][j] == 0)begin
                    match[i] = 1;
                    matchNum[i] = i*SLOT_SIZE+j+1;
                end
            end
        end
    end

    
endmodule