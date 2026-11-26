`timescale 1 ns / 10 ps

module microc_tb;
  wire [5:0] Opcode;
  wire z;
  reg clk, reset, s_inc, s_inm, we3, wez;
  reg [2:0] Op;

  // Instanciación del microcontrolador
  microc uut (
    .Opcode(Opcode), .z(z), .clk(clk), .reset(reset), 
    .s_inc(s_inc), .s_inm(s_inm), .we3(we3), .wez(wez), .Op(Op)
  );

  // Generación del reloj (Período de 20 ns, flancos en 10ns, 30ns, 50ns...)
  always #10 clk = ~clk;

  initial begin
    $dumpfile("microc_tb.vcd");
    $dumpvars(0, microc_tb);

    // 1. Estado inicial y Reset (se mantiene reset en 1 hasta los 15 ns)
    clk = 0;
    reset = 1;
    s_inc = 0; s_inm = 0; we3 = 0; wez = 0; Op = 3'b000;
    #15 reset = 0; 

    // --- CICLO 1 (PC = 0): jmp Start (Salto incondicional a PC = 5) ---
    s_inc = 1'b0; s_inm = 1'b0; we3 = 1'b0; wez = 1'b0; Op = 3'b000; #20;

    // --- CICLO 2 (PC = 5): li 0, R2 (Carga 0 en R2) ---
    s_inc = 1'b1; s_inm = 1'b1; we3 = 1'b1; wez = 1'b0; Op = 3'b000; #20;

    // --- CICLO 3 (PC = 6): li 2, R1 (Carga 2 en R1) ---
    s_inc = 1'b1; s_inm = 1'b1; we3 = 1'b1; wez = 1'b0; Op = 3'b000; #20;

    // --- CICLO 4 (PC = 7): li 4, R3 (Carga 4 en R3) ---
    s_inc = 1'b1; s_inm = 1'b1; we3 = 1'b1; wez = 1'b0; Op = 3'b000; #20;

    // --- CICLO 5 (PC = 8): li 1, R4 (Carga 1 en R4) ---
    s_inc = 1'b1; s_inm = 1'b1; we3 = 1'b1; wez = 1'b0; Op = 3'b000; #20;

    // === ITERACIÓN 1 DEL BUCLE ===
    // Ciclo 6 (PC = 9): add R2, R3, R2 (R2 = 0 + 4 = 4)
    s_inc = 1'b1; s_inm = 1'b0; we3 = 1'b1; wez = 1'b1; Op = 3'b010; #20;

    // Ciclo 7 (PC = 10): sub R1, R4, R1 (R1 = 2 - 1 = 1) -> z pasa a 0
    s_inc = 1'b1; s_inm = 1'b0; we3 = 1'b1; wez = 1'b1; Op = 3'b011; #20;

    // Ciclo 8 (PC = 11): jnz Iter (Como z = 0, s_inc = 0 salta a PC = 9)
    s_inc = z;    s_inm = 1'b0; we3 = 1'b0; wez = 1'b0; Op = 3'b000; #20;

    // === ITERACIÓN 2 DEL BUCLE ===
    // Ciclo 9 (PC = 9): add R2, R3, R2 (R2 = 4 + 4 = 8)
    s_inc = 1'b1; s_inm = 1'b0; we3 = 1'b1; wez = 1'b1; Op = 3'b010; #20;

    // Ciclo 10 (PC = 10): sub R1, R4, R1 (R1 = 1 - 1 = 0) -> z pasa a 1
    s_inc = 1'b1; s_inm = 1'b0; we3 = 1'b1; wez = 1'b1; Op = 3'b011; #20;

    // Ciclo 11 (PC = 11): jnz Iter (Como z = 1, s_inc = 1 avanza a PC = 12)
    s_inc = z;    s_inm = 1'b0; we3 = 1'b0; wez = 1'b0; Op = 3'b000; #20;

    // === BUCLE INFINITO FINAL ===
    // Ciclo 12 (PC = 12): jmp Fin
    s_inc = 1'b0; s_inm = 1'b0; we3 = 1'b0; wez = 1'b0; Op = 3'b000; #20;

    #40;
    $finish;
  end

endmodule