	.file	"fibon.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Cannot read all the data"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"(SUBPROCESS) Fibonacci number %ld is %ld\n"
	.text
	.globl	run_fib
	.type	run_fib, @function
run_fib:
.LFB22:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	$5, 8(%rsp)
	movl	4+p(%rip), %edi
	call	close@PLT
	leaq	8(%rsp), %rsi
	movl	$8, %edx
	movl	p(%rip), %edi
	call	read@PLT
	movq	%rax, %rbx
	movl	p(%rip), %edi
	call	close@PLT
	cmpq	$8, %rbx
	jne	.L5
	movl	$5, %edi
	call	fibonacci@PLT
	movq	%rax, %rdx
	movq	%rax, 16(%rsp)
	movq	8(%rsp), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	o(%rip), %edi
	call	close@PLT
	leaq	16(%rsp), %rsi
	movl	$8, %edx
	movl	4+o(%rip), %edi
	call	write@PLT
	movl	4+o(%rip), %edi
	call	close@PLT
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L6
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$1, %edi
	call	_exit@PLT
.L6:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE22:
	.size	run_fib, .-run_fib
	.section	.rodata.str1.1
.LC2:
	.string	"Hello, World!"
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"Fibonacci number %ld is %ld. (Taken from child process)\n"
	.section	.rodata.str1.1
.LC4:
	.string	"A Child process killed."
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	leaq	p(%rip), %rdi
	call	pipe@PLT
	leaq	o(%rip), %rdi
	call	pipe@PLT
	call	fork@PLT
	testl	%eax, %eax
	jne	.L8
	movl	$0, %eax
	call	run_fib
.L9:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L12
	movl	$0, %eax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L8:
	.cfi_restore_state
	movl	%eax, %ebx
	movl	p(%rip), %edi
	call	close@PLT
	movl	$8, %edx
	leaq	n(%rip), %rsi
	movl	4+p(%rip), %edi
	call	write@PLT
	movl	4+p(%rip), %edi
	call	close@PLT
	movl	4+o(%rip), %edi
	call	close@PLT
	movq	%rsp, %rbp
	movl	$8, %edx
	movq	%rbp, %rsi
	movl	o(%rip), %edi
	call	read@PLT
	movl	o(%rip), %edi
	call	close@PLT
	movq	(%rsp), %rdx
	movq	n(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %edx
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	waitpid@PLT
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	jmp	.L9
.L12:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	n
	.data
	.align 8
	.type	n, @object
	.size	n, 8
n:
	.quad	5
	.globl	o
	.bss
	.align 8
	.type	o, @object
	.size	o, 8
o:
	.zero	8
	.globl	p
	.align 8
	.type	p, @object
	.size	p, 8
p:
	.zero	8
	.ident	"GCC: (GNU) 13.2.1 20230801"
	.section	.note.GNU-stack,"",@progbits
