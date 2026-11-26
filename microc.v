module microc(output wire [5:0] Opcode, output wire z, input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] Op);
 // Cables del PC e Instrucción
  wire [9:0] pc_actual, pc_siguiente, pc_mas_uno;
  wire [15:0] instruccion;
 // Cables de Datos --> Registros y ALU
  wire [7:0] rd1, rd2, wd3, alu_resultado;
  wire z_alu;
 
  registro #(10) pc_reg (.Q(pc_actual), .clk(clk), .reset(reset), .D(pc_siguiente));
  sum sum_pc (.Y(pc_mas_uno), .A(pc_actual), .B(10'd1));
  mux2 #(10) mux_pc (.Y(pc_siguiente), .D0(instruccion[9:0]), .D1(pc_mas_uno), .s(s_inc));
  memprog mem_programa (.Data(instruccion), .clk(clk), .Address(pc_actual));
 
  assign Opcode = instruccion[15:10];
  
  regfile banco_registros (.RD1(rd1), .RD2(rd2), .clk(clk), .we3(we3), .RA1(instruccion[11:8]), .RA2(instruccion[7:4]), .WA3(instruccion[3:0]), .WD3(wd3));
  mux2 #(8) mux_wd3 (.Y(wd3), .D0(alu_resultado), .D1(instruccion[11:4]), .s(s_inm));
  alu #(8) alu_procesador (.R(alu_resultado), .zero(z_alu), .carry(), .sign(), .A(rd1), .B(rd2), .Op(Op));
  ffd ffd_zero (.clk(clk), .reset(reset), .d(z_alu), .carga(wez), .q(z));
endmodule