`timescale 1 ns/10 ps

module FIFO_tb;

logic clk;
logic rst;
logic init_done;
logic [31:0] counter;
logic [31:0] test_timer;

logic in_enque_en;
logic in_valid;
logic [63:0] in_data;
logic out_deque_en;
logic out_valid;
logic [63:0] out_data;

integer file_handle; 
integer data = 123;
initial begin
    file_handle = $fopen ("data_out.txt", "w");  
    $fwrite (file_handle, "%d", data); 
    $fclose (file_handle);
end

initial in_enque_en = 1;
initial in_data = 114514;
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
        if (in_valid==1'b0) begin
            in_enque_en = 1'b0;
            out_deque_en = 1'b1;
        end
        if (test_timer > 30) begin
            $display("testbench init timed out");
            $finish;
        end
    end
end


FIFO #(
    .DWIDTH(64),
    .QUEUE_SIZE(21)
) FIFO_inst (
    .clk(clk),
    .rst(rst),
    .in_enque_en(in_enque_en),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_deque_en(out_deque_en),
    .out_valid(out_valid),
    .out_data(out_data)
);

endmodule