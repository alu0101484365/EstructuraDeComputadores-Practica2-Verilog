//  Implementa una “unidad lógica de 4 bits” de forma estructural, utilizando las celdas lógicas descritas
// en el objetivo 1.2

module ul #(parameter WIDTH = 8)(output wire [WIDTH-1:0] Out, input wire [WIDTH-1:0] A, B, input wire [1:0] S);
    reg [WIDTH-1:0] resultado;
    always @(*) begin
        case (S)
            2'b00: resultado = ~A;
            2'b01: resultado = A & B;
            2'b10: resultado = A | B;
            2'b11: resultado = A ^ B;
            default: resultado = 0;
        endcase
    end
    assign Out = resultado;
endmodule

/*
module ul4(output wire [3:0] Out, input wire [3:0] A, input wire [3:0] B, input wire [1:0] S);
    cl cl0(Out[0], A[0], B[0], S);
    cl cl1(Out[1], A[1], B[1], S);
    cl cl2(Out[2], A[2], B[2], S);
    cl cl3(Out[3], A[3], B[3], S);
endmodule
*/