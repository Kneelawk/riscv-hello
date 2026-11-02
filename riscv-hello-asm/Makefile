default: hello.elf

hello.o: hello.s
	riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 hello.s -o hello.o

hello.elf: hello.o baremetal.ld
	riscv64-unknown-elf-gcc -T baremetal.ld -march=rv32i -mabi=ilp32 -nostdlib -static -o hello.elf hello.o

run: hello.elf
	@echo "Ctrl-A C for QEMU console, then type quit to exit"
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios hello.elf

clean:
	rm -rf hello.o hello.elf
