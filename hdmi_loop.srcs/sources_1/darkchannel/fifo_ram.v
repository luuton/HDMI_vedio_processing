module fifo_ram#(
    parameter DATA_WIDTH = 8,
    parameter DATA_DEPTH = 640
)
(
    input                               clk,
    //写端口
    input                               wr_en,
    input       [DATA_WIDTH - 1 : 0]    wr_data,
    output                              wr_full,
    //读端口
    input                               rd_en,
    output reg  [DATA_WIDTH - 1 : 0]    rd_data,
    output                              rd_empty
);
    //定义 ram
    (*ram_style = "block" *) reg [DATA_WIDTH - 1 : 0] fifo_buffer[DATA_DEPTH - 1 : 0];

    integer i;
    initial begin
        for(i = 0;i<DATA_DEPTH;i = i + 1)begin
            fifo_buffer[i] <=  0;
        end
    end

    reg     [$clog2(DATA_DEPTH) - 1 : 0]    wr_pointer = 0;//从此端读出数据
    reg     [$clog2(DATA_DEPTH) - 1 : 0]    rd_pointer = 0;
    wire    [DATA_WIDTH - 1 : 0]            rd_data_out;

//跟踪写指针
always @(posedge clk) begin
    if (wr_en) begin
        if (wr_pointer == DATA_DEPTH - 1) begin
            wr_pointer <= 0; 
        end
        else begin
            wr_pointer <= wr_pointer + 1;
        end
    end
end

//跟踪读指针 
always @(posedge clk) begin
    if (rd_en) begin
        if (rd_pointer == DATA_DEPTH - 1) begin
            rd_pointer <= 0;
        end
        else begin
            rd_pointer <= rd_pointer + 1;
        end
    end
end

//wr_en 有效时把数据写入 fifo
always @(posedge clk) begin
    if (wr_en) begin
        fifo_buffer[wr_pointer] <= wr_data;
    end
end

assign rd_data_out = rd_en ? fifo_buffer[rd_pointer] : 0;
    
always @(posedge clk) begin
    rd_data <=  rd_data_out;//延迟一拍
end


endmodule