const std = @import("std");
const base64 = @import("base64.zig");
const bsf = base64.bsf;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const base = bsf.init();
    try stdout.print("{s}\n", .{base._table});
}
