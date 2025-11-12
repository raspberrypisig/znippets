const std = @import("std");

const seperator = "-----------------------------------------------------------";

const versions: [3][]const u8 = .{ "0.13.0", "0.14.1", "0.15.2" };

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    std.debug.print("{s}\nZNIPPETS\n", .{seperator});

    var processes: [versions.len]std.process.Child = undefined;
    for (versions, 0..) |version, idx| {
        var buf: [100]u8 = undefined;
        const msg = try std.fmt.bufPrint(&buf, "'Hello world, version: {s}'", .{version});
        processes[idx] = std.process.Child.init(&.{ "echo", msg }, allocator);
        try processes[idx].spawn();
    }

    for (&processes) |*process| {
        _ = try process.wait();
    }
}
