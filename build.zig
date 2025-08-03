const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "bsf",
        .root_source_file = b.path("src/main.zig"),
        .target = b.graph.host,
    });

    const base64_mod = b.addModule("base64", .{
        .root_source_file = b.path("src/base64.zig")
    });
    exe.root_module.addImport("base64", base64_mod);

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
