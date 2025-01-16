///-----------------------
/// build (library)
///-----------------------

const std = @import("std");


pub fn build(b: *std.Build) void {

  
    const mvzr_mod = b.addModule("mvzr", .{
        .root_source_file = b.path( "./regex/mvzr.zig" ),
    });




    
    const library_mod = b.addModule("library", .{
        .root_source_file = b.path( "library.zig" ),
        .imports = &.{
        .{ .name = "mvzr",        .module = mvzr_mod },
 
        },
    });






    
    _ = library_mod;


}
