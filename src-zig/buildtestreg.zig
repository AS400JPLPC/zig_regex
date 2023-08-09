const std = @import("std");


pub fn build(b: *std.Build) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const target   = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
 
    // zig-src            source projet
    // zig-src/deps       curs/ form / outils ....
    // src_c              source c/c++
    // zig-src/srcgo      source go-lang 
    // zig-src/srcgo/lib  lib.so source.h


     // Definition of module
    const match = b.createModule(.{
      .source_file = .{ .path = "./deps/curse/match.zig"},
    });




    // Building the executable

    const Prog = b.addExecutable(.{
    .name = "testreg",
    .root_source_file = .{ .path = "./testreg.zig" },
    .target = target,
    .optimize = optimize,
    });
    Prog.addIncludePath(.{.path = "./lib/"});
    Prog.linkLibC();
    Prog.addObjectFile(.{.cwd_relative = "/usr/lib/libpcre2-posix.so"});
    Prog.addModule("match" , match);

    const install_exe = b.addInstallArtifact(Prog, .{});
    b.getInstallStep().dependOn(&install_exe.step); 

}
