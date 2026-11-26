// Multiplexor de 2 entradas a una salida en el que las entradas son de 4 bits

module mux2 #(parameter WIDTH = 8)(output wire [WIDTH-1:0] Out, input wire [WIDTH-1:0] A, input wire [WIDTH-1:0] B, input wire s);

    assign Out = (s == 1'b0) ? A : B;

endmodule