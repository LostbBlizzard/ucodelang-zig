const std = @import("std");

pub fn addlinks(lib: *std.build.Step.Compile) void {
    lib.addIncludePath(.{ .path = "cfiles" });

    lib.addLibraryPath(.{ .path = "cfiles" });

    lib.linkSystemLibrary("c");
    lib.linkLibC();

    lib.linkSystemLibrary("UCodeLang");
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "UCodeLang",
        .root_source_file = .{ .path = "src/ucodelang.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/ucodelang.zig" },
        .target = target,
        .optimize = optimize,
    });
    addlinks(unit_tests);

    const run_unit_tests = b.addRunArtifact(unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
