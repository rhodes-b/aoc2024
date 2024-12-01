const std = @import("std");

fn part1() !void {
    const input = try std.fs.cwd().openFile("day1-part1.input", .{});
    var left: [1000]u32 = undefined;
    var right: [1000]u32 = undefined;

    for (0..1000) |i| {
        var lnum: [5]u8 = undefined;
        var rnum: [5]u8 = undefined;
        const bytes_read = try input.read(&lnum);
        if (bytes_read != 5) {
            break; // EOF
        }
        try input.seekBy(3);
        _ = try input.read(&rnum);
        try input.seekBy(1);

        const l_num = try std.fmt.parseInt(u32, &lnum, 10);
        const r_num = try std.fmt.parseInt(u32, &rnum, 10);
        left[i] = l_num;
        right[i] = r_num;
    }

    std.mem.sort(u32, &left, {}, comptime std.sort.asc(u32));
    std.mem.sort(u32, &right, {}, comptime std.sort.asc(u32));

    var sum: u64 = 0;
    for (0..1000) |i| {
        const diff: i64 = @as(i64, left[i]) - @as(i64, right[i]);
        sum += @abs(diff);
    }
    std.debug.print("sum1:{d}\n", .{sum});
}

fn part2() !void {
    const input = try std.fs.cwd().openFile("day1-part1.input", .{});
    var left: [1000]u32 = undefined;
    var right: [1000]u32 = undefined;

    for (0..1000) |i| {
        var lnum: [5]u8 = undefined;
        var rnum: [5]u8 = undefined;
        const bytes_read = try input.read(&lnum);
        if (bytes_read != 5) {
            break; // EOF
        }
        try input.seekBy(3);
        _ = try input.read(&rnum);
        try input.seekBy(1);

        const l_num = try std.fmt.parseInt(u32, &lnum, 10);
        const r_num = try std.fmt.parseInt(u32, &rnum, 10);
        left[i] = l_num;
        right[i] = r_num;
    }

    var num_count = std.AutoHashMap(u32, u32).init(std.heap.page_allocator);
    for (right) |val| {
        const curr_count = num_count.get(val);
        if (curr_count) |count| {
            try num_count.put(val, count + 1);
        } else {
            try num_count.put(val, 1);
        }
    }

    var sum: u64 = 0;
    for (left) |index| {
        const count_or = num_count.get(index);
        if (count_or) |count| {
            sum += index * count;
        }
    }
    std.debug.print("sum2:{d}\n", .{sum});
}

pub fn main() !void {
    try part1();
    try part2();
}
