// YOU CAN COMPLETELY IGNORE THIS SNIPPETS
// THERE'S A BUG WHEN GENERATING HTML FILES FOR FILES THAT CONTAINS `<--`
const std = @import("std");

test "non-exhaustive enum" {

    // Non-exhaustive enums must specify a tag type
    // and cannot consume every enumeration value (otherwise it becomes exhaustive)!
    const Status = enum(u10) {
        ok = 200,
        bad_request = 400,
        unauthorized = 401,
        not_found = 404,
        internal_server_error = 500,
        _, // <-- trailing underscore
    };

    std.debug.print("200: {}, other: {}\n", .{ @as(Status, @enumFromInt(200)), @as(Status, @enumFromInt(2)) });
    const util = struct {
        fn doSmth(status: Status) void {
            switch (status) {
                _ => std.debug.print("unknown {}\n", .{status}),
                else => std.debug.print("known status: {}\n", .{status}),
            }
        }
    };

    util.doSmth(.bad_request);
    util.doSmth(@enumFromInt(10));
}
