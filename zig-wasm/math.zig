const std = @import("std");

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

export fn square(n: i32) i32 {
    return n * n;
}

pub fn main() !void {
    const a = 10;
    const b = 20;

    const result = add(a, b);

    std.debug.print("{d} + {d} = {d}", .{a, b, result});
}
