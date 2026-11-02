/* _start is entry point */
ENTRY(_start)

MEMORY {
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M
}

/* Setup sections */
SECTIONS {
    /* Calculate stack top */
    PROVIDE(__stack_top = ORIGIN(RAM) + LENGTH(RAM));

    /* Init section is always first, because that holds the _start function */
    .init : {
        KEEP (*(SORT_NONE(.init)));
    }

    /* Normal code section */
    .text : {
        *(.text .text.*);
    }

    /* Make sure to push the data section off of the text page */
    . = ALIGN (CONSTANT (COMMONPAGESIZE));

    .rodata : {
        *(.rodata .rodata.*);
    }

    . = ALIGN (CONSTANT (COMMONPAGESIZE));

    /* Section for data shipped with the binary */
    .data : {
        __DATA_BEGIN__ = .;
        *(.data .data.*);
    }

    /* Small data section */
    .sdata : {
        __SDATA_BEGIN__ = .;
        *(.sdata .sdata.*);
    }

    /* Uninitialized data section */
    __bss_start = .;
    .sbss : {
        *(.sbss .sbss.*);
    }

    .bss : {
        *(.bss .bss.*);
    }

    __BSS_END__ = .;

    __global_pointer$ = MIN(__SDATA_BEGIN__ + 0x800, MAX(__DATA_BEGIN__ + 800, __BSS_END__ - 0x800));
}
