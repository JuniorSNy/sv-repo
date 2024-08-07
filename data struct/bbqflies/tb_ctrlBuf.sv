`timescale 1 ns/10 ps

import heap_ops::*;

module tb_bbq;

// Simulation parameters. Some testcases implicitly depend
// on the values being set here, so they musn't be changed!
// localparam PERIOD = 10;
// localparam HEAP_BITMAP_WIDTH = (bbq_inst.HEAP_BITMAP_WIDTH);//2;
// localparam HEAP_ENTRY_DWIDTH = (bbq_inst.HEAP_ENTRY_DWIDTH);//17;
// localparam N = (bbq_inst.HEAP_MAX_NUM_ENTRIES);//127; // Maximum heap entries
// localparam HEAP_ENTRY_AWIDTH = ($clog2(N));
// localparam P = (bbq_inst.NUM_PIPELINE_STAGES + 1);
// // localparam P = 20;
// localparam HEAP_NUM_LEVELS = (bbq_inst.HEAP_NUM_LEVELS);
// // localparam HEAP_NUM_LEVELS = 4;
// localparam HEAP_NUM_PRIORITIES = (HEAP_BITMAP_WIDTH ** HEAP_NUM_LEVELS);

// localparam HEAP_PRIORITY_AWIDTH = ($clog2(HEAP_NUM_PRIORITIES));

// localparam HEAP_INIT_CYCLES = (
//     (N > HEAP_NUM_PRIORITIES) ?
//     N : HEAP_NUM_PRIORITIES);

// localparam HEAP_MIN_NUM_PRIORITIES_AND_ENTRIES = (
//     (N < HEAP_NUM_PRIORITIES) ?
//     N : HEAP_NUM_PRIORITIES);

// localparam MAX_HEAP_INIT_CYCLES = (HEAP_INIT_CYCLES << 1);

// // Local typedefs
// typedef logic [HEAP_ENTRY_DWIDTH-1:0] heap_entry_data_t;
// typedef logic [HEAP_PRIORITY_AWIDTH-1:0] heap_priority_t;

logic clk;
logic rst;
logic init_done;
logic [31:0] counter;
logic [31:0] test_timer;

logic in_enque_en;
logic in_valid;
logic [63:0] in_buff_addr;
logic out_deque_en;
logic out_valid;
logic [31:0] out_buff_addr;

initial in_enque_en = 1;
initial in_buff_addr = 114514;
initial out_deque_en = 0;



initial clk = 0;
initial rst = 1;
initial counter = 0;
initial init_done = 0;
initial test_timer = 0;

always #(10) clk = ~clk;

always @(posedge clk) begin
    rst <= 0;
    test_timer <= test_timer + 1;

    if (test_timer) begin
        // counter <= counter + 1;
        // $display("counter: %0d", counter);
        // if (counter == 0) begin
        //     // heap_in_valid <= 1;
        //     // heap_in_data <= 23;
        //     // heap_in_op_type <= HEAP_OP_ENQUE;
        //     // heap_in_priority <= (HEAP_NUM_PRIORITIES - 1);
        // end
        // else if (counter > P) begin
        //     $display("FAIL %s: Test timed out", `TEST_CASE);
        //     $finish;
        // end
        // else if (heap_out_valid) begin
        //     if ((heap_out_data === 23) &&
        //         (heap_out_op_type === HEAP_OP_ENQUE) &&
        //         (heap_out_priority === (HEAP_NUM_PRIORITIES - 1))) begin
        //         $display("PASS %s", `TEST_CASE);
        //         $finish;
        //     end
        //     else begin
        //         $display("FAIL %s: Expected ", `TEST_CASE,
        //                  "(op: HEAP_OP_ENQUE, data: 23, priority: %0d)",
        //                  (HEAP_NUM_PRIORITIES - 1), ", got (%s, %0d, %0d)",
        //                  heap_out_op_type.name, heap_out_data, heap_out_priority);
        //         $finish;
        //     end
        // end
        if (in_valid==1'b0) begin
            in_enque_en = 1'b0;
            out_deque_en = 1'b1;
        end
        if (test_timer > 120) begin
            $display("testbench init timed out");
            $finish;
        end
    end
end


ctrlBuf #(
    .BUFF_ENTRY_DWIDTH(64),
    .OUT_BUFF_SIZE(21)
    
) tb_buf(
    // General I/O
    .clk(clk),
    .rst(rst),

    .in_enque_en(in_enque_en),
    .in_valid(in_valid),
    .in_buff_addr(in_buff_addr),

    .out_deque_en(out_deque_en),
    .out_valid(out_valid),
    .out_buff_addr(out_buff_addr)
);

endmodule