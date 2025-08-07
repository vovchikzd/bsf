const std = @import("std");
const bsf = @import("base64");

pub fn main() !u8 {
    const stdout = std.io.getStdOut().writer();
    const nStrBytes = [_]u8{ 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x2c, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21, 0xa };
    try stdout.print("{s}", .{nStrBytes});
    const nChunksNumber = nStrBytes.len / 3;
    for (0..nChunksNumber) |nChunk| {
        const sEncodeResult = try bsf.encodeChunk(nStrBytes[nChunk * 3 .. nChunk * 3 + 3]);
        try stdout.print("{s}", .{sEncodeResult});
    }
    const baRemaining = nStrBytes[nChunksNumber * 3 ..];
    if (baRemaining.len != 0) {
        try stdout.print("{s}", .{try bsf.encodeChunk(baRemaining)});
    }
    try stdout.print("\n", .{});

    return 0;
}
