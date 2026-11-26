# Lista de archivos fuente
SRCS = microc_tb.v microc.v componentes.v memprog.v alu.v preprocess.v compl1.v sum4.v ul4.v flags.v
TARGET = microc.out

# Compila y ejecuta
all:
	iverilog -o $(TARGET) $(SRCS)

# Limpieza de archivos generados
clean:
# rm -f $(TARGET) *.vcd
	rm -f $(TARGET) microc_tb.vcd
.PHONY: all clean
