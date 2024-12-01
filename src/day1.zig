const std = @import("std");

pub fn run_day1_part1() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("input/day1.txt", .{});
    defer file.close();

    while (try file.reader().readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize))) |line| {
        defer allocator.free(line);
        std.debug.print("{s}\n", .{line});
    }
}
