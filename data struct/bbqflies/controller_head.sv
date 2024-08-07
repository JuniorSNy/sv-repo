package BBQctrl;

typedef struct packed {
    logic [47:0] sMAC; 
    logic [47:0] dMAC; 
    logic [31:0] sIP; 
    logic [31:0] dIP; 
    logic [15:0] sPort; 
    logic [15:0] dPort; 
    logic [31:0] seqNum;
} pkHeadInfo;


typedef enum logic [1:0] {
    POPING_BLACK_BBQ = 0,
    POPING_WHITE_BBQ,
    POPING_STALL
} alterState;

endpackage
