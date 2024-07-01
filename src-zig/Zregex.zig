const std = @import("std");

// tools regex
const creg = @import("match");
// tools fluent regex
const freg = @import("fluent");

const allocatorRegex = std.heap.page_allocator;

 
const expA = "[A-Z]{1}[a-zA-Z0-9]{2,5}";

const expDateIso = 
 "^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$";

 
const expMail = "[a-zA-Z0-9_!#$%&.-]+@([a-zA-Z0-9.-])+";


const expEuro = "^[0-9]{1,5}[.][0-9]{1,2}";


fn isMatch(vbuf : [] const u8 , comptime  vmatch : [] const u8) bool {

 
     
    var rep = freg.match(vmatch,vbuf) ;

    while (rep.next()) |value| {
    const valx = std.fmt.allocPrint(allocatorRegex,"{s}",.{value}) catch unreachable;
    defer allocatorRegex.free(valx);


    const val = std.mem.trim(u8,valx," \n");
    
    // std.debug.print("Fluent Macth >{s}< : >{s}< \r\n",.{vbuf, val}) ;

    if ( std.mem.eql(u8, vbuf, val) ) return true else return false ;
    }

    return false;
}





 
pub fn main() !void {

// ====================================================================================================


    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"Pabcex",isMatch("Pabcex",expA)});
std.debug.print("Macth {s}: {} \r\n",.{"Pabcex",creg.isMatch("Pabcex","^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
std.debug.print("Macth {s}: {} \r\n",.{"Pabcex",creg.isMatch("Pabcex",expA)}) ;
   
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"P1bcex",isMatch("P1bcex",expA)});
    
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"Pabce",isMatch("Pabce",expA)});
    // error
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"aabcex",isMatch("aabcex",expA)});
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"Pabcessx",isMatch("Pabcessx",expA)});



    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"jpl-myname.myfirstname@gmail.com",isMatch("jpl-myname.myfirstname@gmail.com",expMail)});
 std.debug.print("Macth {s}: {} \r\n",.{"jpl-myname.myfirstname@gmail.com",creg.isMatch("jpl-myname.myfirstname@gmail.com",expMail)}) ;
    

    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"1951-02-29",isMatch("1951-02-29",expDateIso)});
 std.debug.print("Macth {s}: {} \r\n",.{"1951-02-29",creg.isMatch("1951-02-29",expA)}) ;
  
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"1952-02-29",isMatch("1952-02-29",expDateIso)});
 std.debug.print("Macth {s}: {} \r\n",.{"1952-02-29",creg.isMatch("1952-02-29",expDateIso)});

    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"12345.02",isMatch("12345.02",expEuro)});
std.debug.print("Macth {s}: {} \r\n",.{"12345.02",creg.isMatch("12345.02",expEuro)}) ;


    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"5.02",isMatch("5.02",expEuro)});
 std.debug.print("Macth {s}: {} \r\n",.{"5.02",creg.isMatch("5.02",expEuro)}) ;
  
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"5.0",isMatch("5.0",expEuro)});
 std.debug.print("Macth {s}: {} \r\n",.{"5.0",creg.isMatch("5.0",expEuro)}) ;
    
    // error 
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"123456.02",isMatch("123456.02",expEuro)});
 std.debug.print("Macth {s}: {} \r\n",.{"123456.02",creg.isMatch("123456.02",expEuro)}) ;
 
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"12345",isMatch("12345",expEuro)});
 std.debug.print("Macth {s}: {} \r\n",.{"12345",creg.isMatch("12345",expEuro)}) ;
    
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"12345.",isMatch("12345.",expEuro)});
 std.debug.print("Macth {s}: {} \r\n",.{"12345.",creg.isMatch("12345.",expEuro)}) ;
   
    
 }
