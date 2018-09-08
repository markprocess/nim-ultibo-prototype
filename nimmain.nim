
proc ultiboProgramThreadYield {.importc.}
proc ultiboProgramSerialConsoleWriteChar(c: char) {.importc.}
proc ultiboProgramGetTickCount: cint {.importc.}

proc write(c: char) =
  ultiboProgramSerialConsoleWriteChar c

proc write(s: string) =
  for c in s:
    write c

proc writeln(s: string) =
  write(s)
  write "\x0a"

proc write(x: int) =
  if x < 10:
    write(char(int('0') + x))
  else:
    write(x div 10)
    write(x mod 10)

#var
#  s = "a" & "b"

proc nimMain {.exportc.} =
  var last= -1
  var now = -1
  while true:
    while now == last:
      now = ultiboProgramGetTickCount() div 1000
      ultiboProgramThreadYield()
    write now
    writeln ""
    last = now
