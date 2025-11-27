const std = @import("std");

test {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var io_threaded: std.Io.Threaded = .init(alloc);
    defer io_threaded.deinit();
    const io = io_threaded.io();

    var client: std.http.Client = .{
        .allocator = alloc,
        .io = io,
    };
    defer client.deinit();

    // var result_body = std.Io.Writer.Allocating.init(alloc);
    // defer result_body.deinit();

    const response = try client.fetch(.{
        .location = .{ .url = "https://google.com/ncr" },
        // .response_writer = &result_body.writer,
    });

    try std.testing.expect(response.status.class() == .success);
}
