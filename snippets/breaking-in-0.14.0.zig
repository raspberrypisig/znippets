test "switch on type info" {
    const x = switch (@typeInfo(u8)) {
        .Int => 0,
        .ComptimeInt => 1,
        .Struct => 2,
        else => 3,
    };
    try std.testing.expectEqual(0, x);
}
test "reify type" {
    const U8 = @Type(.{ .Int = .{
        .signedness = .unsigned,
        .bits = 8,
    } });
    const S = @Type(.{ .Struct = .{
        .layout = .auto,
        .fields = &.{},
        .decls = &.{},
        .is_tuple = false,
    } });
    try std.testing.expect(U8 == u8);
    try std.testing.expect(@typeInfo(S) == .Struct);
}

// ABOVE DOESN'T WORK FOR 0.14.0
// BELOW WORKS FOR 0.14.0

// test "switch on type info, new" {
//     const x = switch (@typeInfo(u8)) {
//         .int => 0,
//         .comptime_int => 1,
//         .@"struct" => 2,
//         else => 3,
//     };
//     try std.testing.expect(0, x);
// }
// test "reify type, new" {
//     const U8 = @Type(.{ .int = .{
//         .signedness = .unsigned,
//         .bits = 8,
//     } });
//     const S = @Type(.{ .@"struct" = .{
//         .layout = .auto,
//         .fields = &.{},
//         .decls = &.{},
//         .is_tuple = false,
//     } });
//     try std.testing.expect(U8 == u8);
//     try std.testing.expect(@typeInfo(S) == .@"struct");
// }

const std = @import("std");
