# Initializes everything needed for more complex languages like C

.section .init, "ax"            # init section is placed before all other text sections
.global _start                  # start is marked as the entrypoint in the LD script
_start:                         # our start position
    .cfi_startproc              # enter function frame for exception unwinder
    .cfi_undefined ra           # ra register should not be reset after end
    .option push                # push option context
    .option norelax             # do not relax assignments
    la gp, __global_pointer$    # setup the global pointer register
    .option pop                 # pop option context
    la sp, __stack_top          # setup stack pointer to point to top of RAM
    mv fp, sp                   # setup frame pointer to the same as stack pointer
    j main                      # jump to main entrypoint
    .cfi_endproc                # exit function frame for exception unwinder
    .end                        # marks end of asm

