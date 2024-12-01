const std = @import("std");

pub fn run_day1_part1() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("input/day1.txt", .{});
    defer file.close();

    var left_list = std.ArrayList(i32).init(allocator);
    defer left_list.deinit();
    var right_list = std.ArrayList(i32).init(allocator);
    defer right_list.deinit();

    while (try file.reader().readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize))) |line| {
        defer allocator.free(line);
        var line_slice = std.mem.splitSequence(u8, line, "   ");
        try left_list.append(try std.fmt.parseInt(i32, line_slice.next().?, 10));
        try right_list.append(try std.fmt.parseInt(i32, line_slice.next().?, 10));
    }

    const left_slice = try left_list.toOwnedSlice();
    std.mem.sort(i32, left_slice, {}, comptime std.sort.asc(i32));
    const right_slice = try right_list.toOwnedSlice();
    std.mem.sort(i32, right_slice, {}, comptime std.sort.asc(i32));

    var accumulator: u64 = 0;
    for (left_slice, right_slice) |left, right| {
        accumulator += @abs(left - right);
    }

    std.debug.print("{}", .{accumulator});
}
