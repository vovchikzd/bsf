const base64 = struct {
    _table: *const [64]u8 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",

    pub fn at(self: base64, index: usize) u8 {
        return self._table[index];
    }

    pub fn encodeChunk(self: base64, chunk: []const u8) ![4] u8 {
        if (chunk.len == 0 or chunk.len > 3) return error.InvalidChunkSize;
        const bFirst = chunk[0];
        const bSecond = if (chunk.len < 2) 0 else chunk[1];
        const bThird = if (chunk.len < 3) 0 else chunk[2];
        return [4]u8{
            self._table[bFirst >> 2]
            , self._table[(bFirst << 6 >> 2) | (bSecond >> 4)]
            , if (bSecond == 0) '=' else self._table[(bSecond << 4 >> 2) | (bThird >> 6)]
            , if (bThird == 0) '=' else self._table[bThird << 2 >> 2]
        };
    }
};

pub fn init() base64 {
    return base64{};
}
