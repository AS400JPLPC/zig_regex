// version 0.12. dev

const std = @import("std");

pub fn build(b: *std.Build) void {
	// Standard release options allow the person running `zig build` to select
	// between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
	const target   = b.standardTargetOptions(.{});
	const optimize = b.standardOptimizeOption(.{});
 
    // zig-src            source projet
    // zig-src/deps       curs/ form / outils ....
    // src_c              source c/c++



    // Definition of dependencies

    const match = b.createModule(.{
      .root_source_file= b.path("./deps/curse/match.zig"),
    });
	match.addIncludePath( b.path("./lib/"));


    const fluent = b.createModule(.{
      .root_source_file= b.path("./deps/curse/fluent.zig"),
    });
	
    // Building the executable
    const Prog = b.addExecutable(.{
    .name = "testreg",
    .root_source_file = b.path("./testreg.zig" ),
    .target = target,
    .optimize = optimize,
    });


    Prog.linkLibC();
    Prog.addObjectFile(.{.cwd_relative = "/usr/lib/libpcre2-posix.so"});
    Prog.root_module.addImport("match"   , match);
    Prog.root_module.addImport("fluent"  , fluent);

    b.installArtifact(Prog);



}
