const std = @import("std");

// regex pure ZIG
const freg = @import("mvzr");


// tools regex  lib pcre2
const reg = @import("match");


const allocatorPrint = std.heap.page_allocator;

pub fn isMatch(testval : [] const u8, pattern : [] const u8 ) bool {

    
     const maybe_regex = freg.compile(pattern) ;
     std.debug.print("\r\nlog {s}  {s}\r\n",.{testval,pattern});
     if (maybe_regex) |regex|{
         const match1 = regex.match(testval);
        if (match1) |m1| {
            if (testval.len ==  m1.end) return true;
        } else {
            return false;
        }   
     }  
     return false ;   
       
 }

 
pub fn isMatchiFixedIso(testval : [] const u8) void { 
    
  const ops, const sets = freg.resourcesNeeded("([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)");  
    
    const SlimmedDownRegex = freg.SizedRegex(ops, sets);
    const maybe_regex = SlimmedDownRegex.compile("([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)") ;
    if (maybe_regex) |regex| std.debug.print("MVZR {s} date iso{} \r\n",.{testval, regex.isMatch(testval)}) 
     else  std.debug.print("MVZR {s} date iso{} \r\n",.{testval,false});
}

pub fn isMatchiFixedFr(testval : [] const u8) void {

	const valtest = std.fmt.allocPrint(
		allocatorPrint,
		"{s}-{s}-{s}",
		.{ testval[6..10], testval[3..5], testval[0..2]}) catch unreachable;
	
       const ops, const sets = freg.resourcesNeeded("([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)");  
    
    const SlimmedDownRegex = freg.SizedRegex(ops, sets);
    const maybe_regex = SlimmedDownRegex.compile("([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)") ;

   if (maybe_regex) |regex| std.debug.print("MVZR {s} date iso{} \r\n",.{valtest, regex.isMatch(valtest)}) 
     else  std.debug.print("MVZR {s} date iso{} \r\n",.{valtest,false});
}

pub fn isMatchiFixedUs(testval : [] const u8) void {

	const valtest = std.fmt.allocPrint(
		allocatorPrint,
		"{s}-{s}-{s}",
		.{ testval[6..10], testval[0..2], testval[3..5]}) catch unreachable;
	
       const ops, const sets = freg.resourcesNeeded("([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)");  
    
    const SlimmedDownRegex = freg.SizedRegex(ops, sets);
    const maybe_regex = SlimmedDownRegex.compile("([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)") ;

   if (maybe_regex) |regex| std.debug.print("MVZR {s} date iso{} \r\n",.{valtest, regex.isMatch(valtest)}) 
     else  std.debug.print("MVZR {s} date iso{} \r\n",.{valtest,false});
}


pub fn main() !void {

const stdin = std.io.getStdIn().reader();
var buf : [3]u8 = undefined;
buf = [_]u8{0} ** 3;

std.debug.print("test emprient memoire",.{});
  _= try stdin.readUntilDelimiterOrEof(buf[0..], '\n');


    std.debug.print("Macth A-Z {} \r\n",.{reg.isMatch("P1","^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
    std.debug.print("MVZR  A-Z {} \r\n",.{isMatch("P1","^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;

    std.debug.print("Macth abc {} \r\n",.{reg.isMatch("pppp-1","^[a-zA-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
    std.debug.print("MVZR abc {} \r\n",.{isMatch("pppp-1","^[a-zA-Z]{1,1)([a-zA-Z0-9]{0,})$")}) ;

    
    std.debug.print("MVZR abc {} \r\n",.{isMatch("p3","^[a-zA-Z]{1}[a-zA-Z0-9]{0,}$")}) ;

        
  std.debug.print("Macth digit {} \r\n",.{reg.isMatch(
  "423",
  "^[1-9]{1,1}[0-9]{2,2}$")}) ;

  std.debug.print("MVZR digit {} \r\n",.{isMatch(
  "423",
  "^[1-9]{1}[0-9]{2,2}$")}) ;

  std.debug.print("Macth tel fr{} \r\n",.{reg.isMatch(
  "+(33)6.12.34.56.78",
  "[+][(][0-9]{2,3}[)][0-9]([-.0-9]{1,3}){1,4}")}) ;

  std.debug.print("MVZR tel fr{} \r\n",.{isMatch(
  "+(33)6.12.34.56 78",
  "[+][(][0-9]{2,3}[)][0-9]([-. ]?[0-9]{1,3}){1,4}")}) ;


  std.debug.print("Macth tel us{} \r\n",.{reg.isMatch(
  "+(001)456.123.789.123",
  "[+][(][0-9]{3}[)][0-9]{3}([-.][0-9]{3}){1,4}")}) ;

  std.debug.print("MVZR tel us{} \r\n",.{isMatch(
  "+(001)456.123.789.123",
  "[+][(][0-9]{3}[)][0-9]{3}([-. ]?[0-9]{3}){1,4}")}) ;

 
  std.debug.print("Macth date fr{} \r\n",.{reg.isMatch(
  "12/10/1951",
  "(0[1-9]|[12][0-9]|3[01])[\\/](0[1-9]|1[012])[\\/][0-9]{4}")});
 
  std.debug.print("MVZR date fr{} \r\n",.{isMatch(
  "12/10/1951",
  "(0[1-9]|[12][0-9]|3[01])[\\/](0[1-9]|1[012])[\\/][0-9]{4}")});


  std.debug.print("Macth date us{} \r\n",.{reg.isMatch(
  "10/12/1951",
  "(0[1-9]|1[012])[\\/](0[1-9]|[12][0-9]|3[01])[\\/][0-9]{4}")});

  std.debug.print("MVZR date us{} \r\n",.{isMatch(
  "10/12/1951",
  "(0[1-9]|1[012])[\\/](0[1-9]|[12][0-9]|3[01])[\\/][0-9]{4}")});


  std.debug.print("Macth date iso{} \r\n",.{reg.isMatch(
  "2003-02-25",
  "[0-9]{4}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])")});

  std.debug.print("MVZR date iso{} \r\n",.{isMatch(
  "2003-02-25",
  "[0-9]{4}[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])")});


  //oreilly
  std.debug.print("Macth Mail{} \r\n",.{reg.isMatch(
  "myname.myfirstname@gmail.com",
  "^[a-zA-Z0-9_!#$%&'*+\\/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")});


  // standard mail
  std.debug.print("MVZR Mail{} \r\n",.{isMatch(
  "myname.my~f{i}r/st_n'*a`me@gmail.com-ase",
  "^[a-zA-Z0-9_!#$%&=.-^~|?*+'`{}/]+@([a-zA-Z0-9.-])+$")});

  
  const width :usize = 5;
  // unsigned digit
  std.debug.print("Macth digit unsigned{} \r\n",.{reg.isMatch(
  "123",
  std.fmt.allocPrint(allocatorPrint,"^[0-9]{s}{d}{s}$",.{"{1,",width,"}"},) catch unreachable)});

  std.debug.print("MVZR digit unsigned{} \r\n",.{isMatch(
  "123",
  std.fmt.allocPrint(allocatorPrint,"[0-9]{{1,{d}}}",.{width}) catch unreachable)});


  // unsigned digit
  std.debug.print("Macth digit {} \r\n",.{reg.isMatch(
  "+12345",
  std.fmt.allocPrint(allocatorPrint,"^[+-][0-9]{s}{d}{s}$",.{"{1,",width,"}"}) catch unreachable)});

  std.debug.print("MVZR digit {} \r\n",.{isMatch(
  "+12345",
  std.fmt.allocPrint(allocatorPrint,"([+]|[-])[0-9]{{1,{d}}}",.{width}) catch unreachable)});


  
  // decimal unsigned  scal = 0
  std.debug.print("Macth decimal unsigned  scal = 0 {} \r\n",.{reg.isMatch(
  "12345",
  std.fmt.allocPrint(allocatorPrint,"^[0-9]{s}1,{d}{s}$",.{"{",width,"}"}) catch unreachable)});

  std.debug.print("MVZR decimal unsigned  scal = 0 {} \r\n",.{isMatch(
  "12345",
  std.fmt.allocPrint(allocatorPrint,"[0-9]{{1,{d}}}",.{width}) catch unreachable)});


  const scal :usize = 2;
  // decimal unsigned  scal > 0
  std.debug.print("Macth decimal unsigned  scal > 0 {} \r\n",.{reg.isMatch(
  "12345.02",
  std.fmt.allocPrint(allocatorPrint,
   "^[0-9]{{1,{d}}}[.][0-9]{{{d}}}$",.{width,scal}
  ) catch unreachable)});

  std.debug.print("MVZR decimal unsigned  scal > 0 {} \r\n",.{isMatch(
  "12345.02",
  std.fmt.allocPrint(allocatorPrint,
   "[0-9]{{1,{d}}}[.][0-9]{{{d}}}",.{width,scal}
  ) catch unreachable)});

 
  // decimal signed   scal = 0
  std.debug.print("Macth decimal signed  scal = 0 {} \r\n",.{reg.isMatch(
  "+12345",
  std.fmt.allocPrint(allocatorPrint,"^[+-][0-9]{s}1,{d}{s}$",.{"{",width,"}"},) catch unreachable)});

  std.debug.print("MVZR decimal signed  scal = 0 {} \r\n",.{isMatch(
  "+12345",
  std.fmt.allocPrint(allocatorPrint,"([+]|[-])[[0-9]{s}1,{d}{s}",.{"{",width,"}"},) catch unreachable)});


  // decimal unsigned  scal > 0
  std.debug.print("Macth decimal signed  scal > 0 {} \r\n",.{reg.isMatch(
  "+12345.02",
  std.fmt.allocPrint(allocatorPrint,
  "^[+-][0-9]{s}1,{d}{s}[.][0-9]{s}{d}{s}$",.{"{",width,"}","{",scal,"}"}
  ) catch unreachable)});

  std.debug.print("MVZR decimal signed  scal > 0 {} \r\n",.{isMatch(
  "+12345.02",
  std.fmt.allocPrint(allocatorPrint,
  "([+]|[-])[0-9]{{1,{d}}}[.][0-9]{{{d}}}",.{width,scal}
  ) catch unreachable)});



  // control date
    std.debug.print("-----------------------\r\n",.{});
     // test date réel iso contrôl full
    std.debug.print("Macth {s} date iso{} \r\n",.{"1951-02-20",reg.isMatch(
    "1951-02-20",
    "([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)")});


    isMatchiFixedIso("1951-02-20");
       
    // std.debug.print("MVZR {s} date iso{} \r\n",.{"1951-02-20",isMatch(
    // "1951-02-20",
    // "([0-9]{4}[-]?((0[13-9]|1[012])[-]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-]?31|02[-]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-]?02[-]?29)")});

    isMatchiFixedFr("28/02/0100");
    isMatchiFixedFr("29/02/1951");


    isMatchiFixedUs("02/28/4951");
    isMatchiFixedUs("02/29/1951");
         
  std.debug.print("Macth A-Z {} \r\n",.{reg.isMatch("😀P1😀","^😀[A-Z0-9]{1,2}😀$")}) ;

  std.debug.print("MVZR A-Z {} \r\n",.{isMatch("😀P😀","^😀[A-Z0-9]{1,2}😀$")}) ;
buf = [_]u8{0} ** 3;
  _= try stdin.readUntilDelimiterOrEof(buf[0..], '\n');

    
 }
