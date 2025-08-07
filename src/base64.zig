const _table: []const u8 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

fn at(index: usize) u8 {
    return _table[index];
}

pub fn encodeChunk(chunk: []const u8) ![4] u8 {
    if (chunk.len == 0 or chunk.len > 3) return error.InvalidChunkSize;
    const bFirst = chunk[0];
    const bSecond = if (chunk.len < 2) 0 else chunk[1];
    const bThird = if (chunk.len < 3) 0 else chunk[2];
    return [4]u8{
        _table[bFirst >> 2]
        , _table[(bFirst << 6 >> 2) | (bSecond >> 4)]
        , if (bSecond == 0) '=' else _table[(bSecond << 4 >> 2) | (bThird >> 6)]
        , if (bThird == 0) '=' else _table[bThird << 2 >> 2]
    };
}
