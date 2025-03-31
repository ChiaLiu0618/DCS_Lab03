module AutoPay(
    input               clk,
    input               rst_n,
    input               credit_valid,
    input       [7:0]   credit,
    input               price_valid,
    input       [5:0]   price,
    output reg          out_valid,
    output reg  [8:0]   out_data
);

//==================================================================
// parameter & integer
//==================================================================
parameter WARN = 9'b1_0000_0000;

parameter IDLE = 3'd0, PRICE_IN_1 = 3'd1, PRICE_IN_2 = 3'd2, PRICE_IN_3 = 3'd3, OUTPUT = 3'd4;

//==================================================================
// Regs
//==================================================================
reg [2:0] state, next_state;

reg [7:0] balance;


//==================================================================
// Wires
//==================================================================
reg insufficient_flag;

//==================================================================
// Design
//==================================================================
always @(*) begin
    if(insufficient_flag) next_state = IDLE;
    else begin
        case(state)
            IDLE: next_state = credit_valid ? PRICE_IN_1 : IDLE;
            PRICE_IN_1: next_state = price_valid ? PRICE_IN_2 : PRICE_IN_1;
            PRICE_IN_2: next_state = price_valid ? PRICE_IN_3 : PRICE_IN_2;
            PRICE_IN_3: next_state = price_valid ? OUTPUT : PRICE_IN_3;
            OUTPUT : next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) state <= IDLE;
    else state <= next_state;
end


// BALANCE
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) balance <= 8'b0;
    else begin
        case(state)
            IDLE: balance <= credit_valid ? credit : 8'b0;
            PRICE_IN_1: balance <= price_valid ? (balance - price) : balance;
            PRICE_IN_2: balance <= price_valid ? (balance - price) : balance;
            PRICE_IN_3: balance <= price_valid ? (balance - price) : balance;
            default: balance <= balance;
        endcase
    end 
end


// FLAG
always @(posedge clk or negedge rst_n) begin
    case(state)
        PRICE_IN_1: insufficient_flag <= price_valid ? (balance < price) : 1'b0;
        PRICE_IN_2: insufficient_flag <= price_valid ? (balance < price) : 1'b0;
        PRICE_IN_3: insufficient_flag <= price_valid ? (balance < price) : 1'b0;
        default: insufficient_flag <= 1'b0;
    endcase
end

// OUTPUT
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        out_valid <= 1'b0;
        out_data <= 9'b0;
    end
    else begin
        case(state)
            PRICE_IN_2: begin
                out_valid <= insufficient_flag;
                out_data <= insufficient_flag ? WARN : 9'b0;
            end
            PRICE_IN_3: begin
                out_valid <= insufficient_flag;
                out_data <= insufficient_flag ? WARN : 9'b0;
            end
            OUTPUT: begin
                out_valid <= 1'b1;
                out_data <= insufficient_flag ? WARN : {1'b0, balance};
            end
            default: begin
                out_valid <= 1'b0;
                out_data <= 9'b0;
            end
        endcase
    end
end

endmodule
