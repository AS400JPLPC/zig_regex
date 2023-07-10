const std = @import("std");


pub fn build(b: *std.Build) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const target   = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
 




    // Building the executable

    const Prog = b.addExecutable(.{
    .name = "testreg",
    .root_source_file = .{ .path = "./testreg.zig" },
    .target = target,
    .optimize = optimize,
    });
    Prog.addIncludePath("./lib/");
    Prog.linkLibC();
    Prog.addObjectFile("/usr/lib/libpcre2-posix.so");
    const install_exe = b.addInstallArtifact(Prog);
    b.getInstallStep().dependOn(&install_exe.step); 

}
