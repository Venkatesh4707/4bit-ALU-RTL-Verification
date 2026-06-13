// ============================================================
// Module      : alu_4bit
// Description : 4-bit ALU — 8 operations, opcode-based control
// Author      : P. Venkatesh Sagar
// Date        : June 2026
// ============================================================
// Opcodes:
//   3b000 — ADD  : result = A + B
//   3b001 — SUB  : result = A - B
//   3b010 — AND  : result = A & B
//   3b011 — OR   : result = A | B
//   3b100 — XOR  : result = A ^ B
//   3b101 — SLT  : result = (A < B) ? 1 : 0
//   3b110 — SLL  : result = A << 1
//   3b111 — SRL  : result = A >> 1
// ============================================================

module alu_4bit (
    input  [3:0] A,        // Operand A
    input  [3:0] B,        // Operand B
    input  [2:0] opcode,   // Operation select
    output reg [4:0] result, // 5-bit result (handles overflow)
    output reg       zero,   // High when result == 0
    output reg       overflow // High on ADD/SUB overflow
);

    // Operation parameters
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR  = 3'b011;
    localparam XOR = 3'b100;
    localparam SLT = 3'b101;
    localparam SLL = 3'b110;
    localparam SRL = 3'b111;

    always @(*) begin
        overflow = 1'b0;
        case (opcode)
            ADD: begin
                result   = {1'b0, A} + {1'b0, B};
                overflow = result[4]; // Carry out = overflow
            end
            SUB: begin
                result   = {1'b0, A} - {1'b0, B};
                overflow = (B > A);   // Borrow = overflow
            end
            AND: result = {1'b0, A & B};
            OR:  result = {1'b0, A | B};
            XOR: result = {1'b0, A ^ B};
            SLT: result = (A < B) ? 5'b00001 : 5'b00000;
            SLL: result = {1'b0, A[2:0], 1'b0}; // Shift left by 1
            SRL: result = {1'b0, 1'b0, A[3:1]}; // Shift right by 1
            default: result = 5'b0;
        endcase
        zero = (result[3:0] == 4'b0000);
    end

endmodule
