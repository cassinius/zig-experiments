const std = @import("std");
const net = std.net;
const StreamServer = net.StreamServer;
const Address = net.Address;
// This makes the whole thing async...!?
pub const io_mode = .evented;

/// Async Webserver : TCP Listener + HTTP protocol + handlers
/// Two ways of using it:
/// 1. Library => create a webserver with config
/// 2. Executable => gets a config file in YAML
pub fn main() anyerror!void {
    try printStuff();

    var stream_server = StreamServer.init(.{});

    defer stream_server.close();

    const address = try Address.resolveIp("127.0.0.1", 5445);

    try stream_server.listen(address);

    while (true) {
        const connection = try stream_server.accept();

        try connection.stream.writer().print("Irvicius from Zig TCP WebServer...\n", .{});

        connection.stream.close();
    }
}

fn printStuff() anyerror!void {
    std.log.info("Blahoo!", .{});
    std.log.warn("Omg, iceberg ahead!", .{});
    std.log.err("We're sinking {s} help in sight!!", .{"NO"});
    std.log.debug("Lamest debug info ever...", .{});
}

// pub fn main() !void {
//     // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
//     std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

//     // stdout is for the actual output of your application, for example if you
//     // are implementing gzip, then only the compressed bytes should be sent to
//     // stdout, not any debugging messages.
//     const stdout_file = std.io.getStdOut().writer();
//     var bw = std.io.bufferedWriter(stdout_file);
//     const stdout = bw.writer();

//     try stdout.print("Run `zig build test` to run the tests.\n", .{});

//     try bw.flush(); // don't forget to flush!
// }

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }
