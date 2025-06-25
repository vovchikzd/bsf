pub const bsf = struct {
    _table: *const [64]u8 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",

    pub fn init() bsf {
        return bsf{};
    }
};
