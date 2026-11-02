const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .riscv32,
        .cpu_model = .{ .explicit = &std.Target.riscv.cpu.baseline_rv32 },
        .os_tag = .freestanding,
    });

    const module = b.createModule(.{
        .root_source_file = b.path("hello.zig"),
        .target = target,
    });

    module.addAssemblyFile(b.path("crt0.s"));

    const elf = b.addExecutable(.{
        .name = "hello.elf",
        .root_module = module,
    });

    elf.setLinkerScript(b.path("baremetal.ld"));

    b.installArtifact(elf);

    const run_qemu = b.addSystemCommand(&[_][]const u8{
        "qemu-system-riscv32",
        "-nographic",
        "-serial", "mon:stdio",
        "-machine", "virt",
        "-bios",
    });
    run_qemu.addFileArg(elf.getEmittedBin());
    run_qemu.step.dependOn(&elf.step);

    const run_step = b.step("run", "Run the application in QEMU");
    run_step.dependOn(&run_qemu.step);
}

