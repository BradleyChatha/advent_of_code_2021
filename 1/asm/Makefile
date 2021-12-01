solution : app.asm common.asm entry.asm time.c
	nasm -f elf64 -i . -o solution.o entry.asm
	clang -no-pie solution.o time.c -osolution