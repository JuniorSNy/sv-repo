import heap_ops::*;
import BBQctrl::*;
// `define DEBUG

/**
 * Implements an integer priority queue in hardware using a configurable
 * Hierarchical Find First Set (HFFS) Queue. The implementation is fully
 * pipelined, capable of performing one operation (enqueue, dequeue-*,
 * or peek) every cycle.
 */
module BBQctrlUnit #(
    parameter HEAP_ENTRY_DWIDTH = 32,
    parameter OUT_BUFF_SIZE = 16
    // parameter HEAP_MAX_NUM_ENTRIES = ((1 << 17) - 1),
    // localparam HEAP_BITMAP_WIDTH = 2, // Bitmap bit-width
    // localparam HEAP_NUM_LPS = 2, // Number of logical BBQs
    // localparam HEAP_LOGICAL_BBQ_AWIDTH = ($clog2(HEAP_NUM_LPS)),
    // localparam HEAP_ENTRY_AWIDTH = ($clog2(HEAP_MAX_NUM_ENTRIES)),
    // localparam HEAP_NUM_LEVELS = 2, // Number of bitmap tree levels
    // localparam HEAP_NUM_PRIORITIES = (HEAP_BITMAP_WIDTH ** HEAP_NUM_LEVELS),
    // localparam HEAP_PRIORITY_BUCKETS_AWIDTH = ($clog2(HEAP_NUM_PRIORITIES)),
    // localparam HEAP_NUM_PRIORITIES_PER_LP = (HEAP_NUM_PRIORITIES / HEAP_NUM_LPS),
    // localparam HEAP_PRIORITY_BUCKETS_LP_AWIDTH = ($clog2(HEAP_NUM_PRIORITIES_PER_LP))
) (
    // General I/O
    input   logic                                       clk,
    input   logic                                       rst,

    // output  logic                                       ready,

    // Operation input
    input   logic                                       in_valid,
    input   pkHeadInfo                                  in_hd_info,
    input   logic [HEAP_ENTRY_DWIDTH-1:0]               in_buff_addr,
    // 
    // input   logic [HEAP_PRIORITY_BUCKETS_AWIDTH-1:0]    in,

    // Operation output
    output  logic                                       out_valid,
    output  logic [HEAP_ENTRY_DWIDTH-1:0]               out_buff_addr
);



endmodule