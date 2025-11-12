const std = @import("std");

// written under 0.16.0-dev.1301+cbfa87cbe

const seperator = eolSeparator(80);

const zig_versions: [3][]const u8 = .{ "0.13.0", "0.14.1", "0.15.2" };

fn eolSeparator(comptime size: comptime_int) [size]u8 {
    return @splat('-');
}

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    std.debug.print("ZNIPPETS\n{s}\n", .{seperator});

    // 1. Testing zigup that exists -------------------------------------------
    std.debug.print("1. Testing zigup {s}\n", .{eolSeparator(80 - 17)});
    var zigup_existence_proc = std.process.Child.init(
        &.{ "sh", "-c", "command -v zigup" },
        allocator,
    );
    zigup_existence_proc.stdout_behavior = .Ignore;
    const zigup_test_existence_res = zigup_existence_proc.spawnAndWait() catch |err| {
        std.debug.print("{}\n", .{err});
        @panic("Checking the existence of zigup failed");
    };
    if (zigup_test_existence_res.Exited == 0) {
        std.debug.print("1. zigup was found. Proceeding...\n", .{});
    } else {
        @panic("zigup wasn't found!");
    }

    // 2. Get list of snippets ------------------------------------------------

    return;
    //
    // var processes: [zig_versions.len]std.process.Child = undefined;
    // for (zig_versions, 0..) |version, idx| {
    //     var buf: [100]u8 = undefined;
    //     const msg = try std.fmt.bufPrint(&buf, "'Hello world, version: {s}'", .{version});
    //     processes[idx] = std.process.Child.init(&.{ "echo", msg }, allocator);
    //     try processes[idx].spawn();
    // }
    //
    // for (&processes) |*process| {
    //     _ = try process.wait();
    // }
}
