

module alu #(parameter WIDTH = 8)(output wire [WIDTH-1:0] R, output wire zero, carry, sign, input wire [WIDTH-1:0] A, B, input wire [2:0] Op);

    // Instanciamos los cables internos que nos permitirán conectar las salidas de los bloques
    wire [WIDTH-1:0] AMod, BMod, sum_out, ul_out;
    wire add1, c_out;

    preprocess #(WIDTH) preprocess_1(AMod, BMod, add1, A, B, Op);
    sum_alu #(WIDTH) sum4_1(sum_out, c_out, AMod, BMod, add1);
    ul #(WIDTH) ul4_1(ul_out, AMod, BMod, Op[1:0]);
    mux2 #(WIDTH) mux_1(R, sum_out, ul_out, Op[2]);
    flags #(WIDTH) flags_1(carry, zero, sign, R, c_out);


endmodule