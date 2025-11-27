const std = @import("std");

test {
    var letters = [_]u8{ 'A', 'B', 'C', 'G', 'E', 'F', 'D' };
    var numbers = [_]u8{ 0, 1, 2, 6, 4, 5, 3 };

    const Context = struct {
        letters: []u8,
        numbers: []u8,
        pub fn lessThan(ctx: @This(), lhs: usize, rhs: usize) bool {
            return ctx.letters[lhs] < ctx.letters[rhs];
        }

        pub fn swap(ctx: @This(), lhs: usize, rhs: usize) void {
            std.mem.swap(u8, &ctx.letters[lhs], &ctx.letters[rhs]);
            std.mem.swap(u8, &ctx.numbers[lhs], &ctx.numbers[rhs]);
        }
    };

    const ctx: Context = .{ .letters = &letters, .numbers = &numbers };
    std.sort.pdqContext(0, numbers.len, ctx);
    for (letters, numbers, 0..) |s, r, i| {
        try std.testing.expectEqual(i, r);
        try std.testing.expectEqual('A' + i, s);
    }
}
