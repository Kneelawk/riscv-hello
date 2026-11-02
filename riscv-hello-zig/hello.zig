const uart0_base: usize = 0x10000000;

pub fn reg(comptime base: usize, comptime offset: usize) *u8 {
    return @ptrFromInt(base + offset);
}

const uart0_dr = reg(uart0_base, 0x00);
const uart0_fcr = reg(uart0_base, 0x02);
const uart0_lsr = reg(uart0_base, 0x05);

const uartfcr_ffena: u8 = 0x01;
const uartlsr_thre: u8 = 0x20;

pub inline fn uart0_ff_thr_empty() bool {
    return (uart0_lsr.* & uartlsr_thre) != 0;
}

pub fn uart_putc(c: u8) void {
    while (!uart0_ff_thr_empty()) {}
    uart0_dr.* = c;
}

pub fn uart_puts(str: []const u8) void {
    for (str) |c| {
        uart_putc(c);
    }
}

export fn main() callconv(.c) noreturn {
    uart0_fcr.* = uartfcr_ffena;

    uart_puts("Hello World!");
    while (true) {}
}
