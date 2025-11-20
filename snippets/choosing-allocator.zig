const std = @import("std");
const builtin = @import("builtin");
const native_os = builtin.os.tag;

var debug_allocator: std.heap.DebugAllocator(.{}) = .init;

test {
    const gpa, const is_debug = gpa: {
        if (native_os == .wasi) break :gpa .{ std.heap.wasm_allocator, false };
        break :gpa switch (builtin.mode) {
            .Debug, .ReleaseSafe => .{ debug_allocator.allocator(), true },
            .ReleaseFast, .ReleaseSmall => .{ std.heap.smp_allocator, false },
        };
    };
    defer if (is_debug) {
        _ = debug_allocator.deinit();
    };

    const a = try gpa.create(u8);
    defer gpa.destroy(a);
    a.* = 2;
    try std.testing.expectEqual(2, a.*);
}
