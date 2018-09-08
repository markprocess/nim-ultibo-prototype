program UltiboProgram;
{$mode delphi}

uses 
 VersatilePB,QEMUVersatilePBWithoutServices,Threads,SysUtils,Ultibo;

procedure NimMain; cdecl; external 'libnimmain' name 'nimMain';

procedure ultiboProgramSerialConsoleWriteChar(C:Char) cdecl;
public name 'ultiboProgramSerialConsoleWriteChar';
begin
 PLongWord(VERSATILEPB_UART0_REGS_BASE)^ := Ord(C);
end;

function ultiboProgramGetTickCount:Integer; cdecl;
public name 'ultiboProgramGetTickCount';
begin
 Result:=GetTickCount;
end;

procedure ultiboProgramThreadYield; cdecl;
public name 'ultiboProgramThreadYield';
begin
 ThreadYield;
end;

procedure Log(S:String);
var 
 I:Integer;
begin
 for I:=Low(S) to High(S) do
  ultiboProgramSerialConsoleWriteChar(S[I]);
 ultiboProgramSerialConsoleWriteChar(Char(10));
end;

begin
 Log(Format('UltiboProgram begin at %d ticks',[GetTickCount]));
 NimMain;
end.
