default: hello.elf

hello.o: hello.c
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -march=rv32i -mabi=ilp32 -o hello.o hello.c

crt0.o: crt0.s
	riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 crt0.s -o crt0.o

hello.elf: hello.o crt0.o riscv32-virt.ld
	riscv64-unknown-elf-gcc -T riscv32-virt.ld -march=rv32i -mabi=ilp32 -nostdlib -static -o hello.elf hello.o crt0.o

run: hello.elf
	@echo "Ctrl-A C for QEMU, then type quit to exit"
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios hello.elf

clean:
	rm -rf hello.o crt0.o hello.elf
