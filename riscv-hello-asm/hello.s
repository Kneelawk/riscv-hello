.equ UART_BASE, 0x10000000

.section .text
    la      a0, helloworld          # Load address of hello world string
    li      a1, UART_BASE           # Load uart tx base address
    call    puts                    # Print string

loop:
    j       loop                    # Loop forever because there is no OS to return to

puts:
    lb      t0, (a0)                # Load a char from the string
    beqz    t0, done                # Check for null-termination
    sb      t0, (a1)                # Write char to UART
    addi    a0, a0, 1               # Increment a0 to the next char in the string
    j       puts                    # Return for next character
done:
    ret

.section .data
helloworld:
.string     "Hello World!"
