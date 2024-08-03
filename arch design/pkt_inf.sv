package pkt_h;

typedef struct packed {
    logic [47:0] sMAC; 
    logic [47:0] dMAC; 
    logic [31:0] sIP; 
    logic [31:0] dIP; 
    logic [15:0] sPort; 
    logic [15:0] dPort; 
    logic [31:0] seqNum;
    logic [31:0] size;
    logic [5:0]  NoF;
} pkHeadInfo;

typedef struct packed {
    logic [31:0] sIP; 
    logic [31:0] dIP; 
    logic [15:0] sPort; 
    logic [15:0] dPort; 
    logic [5:0]  NoF;
} QuadSet;

typedef struct packed {
    logic out_valid;
    logic used;
    logic [5:0] tm; 
    pkHeadInfo Info;
} Ringslot;


endpackage