program PhoneBook;

uses crt,sysutils;

const
  NameRequest='Kerem a nevet: ';
  AddressRequest='Kerem a cimet: ';
  TelephoneNumberRequest='Kerem a telefonszamot: ';
  MobilePhoneNumberRequest='Kerem a mobiltelefonszamot: ';
  ExitString='Nyomj egy ENTER-t a kilepeshez!';

  FirstNames:array [1..6] of string = ('Nagy','Kis','Toth','Lakatos', 'Horvath','Dobos');
  LastNames:array [1..6] of string = ('Janos','Andrea','Levente','Cecilia','Robert','Erika');
  AddressSample:array [1..5] of string =('Bem utca','Liliom ter','Arpad ut','Hajnal utca','Mikszath korut');
  TelephoneNumberSample:string ='0642';
  MobilePhoneNumberSample:array [1..3] of string = ('0630','0670','0620');

type
  PDatas=^RDatas;
  RDatas=record
         Name:string;
         Address:string;
         TelephoneNumber:string;
         MobilePhoneNumber:string;
         NextData:PDatas;
        end;

  DataRecord=record
         Name:string;
         Addr:string;
         Tel:string;
         MTel:string;
  end;

  InfStringArray=array of string;
  InfDataRecord=array of DataRecord;

var
  Datas:RDatas;
  DatasFirst, DatasLast, DatasNew, DatasTemp:PDatas;
  ExitNumber:byte;
  HowManyArray:InfStringArray;
  HowManyRows:longint;
  DataRecords:InfDataRecord;

procedure FillDatas;
var
  HowMuch:integer;
  FixNumber:longint;
begin
  for HowMuch:=1 to 22 do
      begin
         new(DatasNew);
         with DatasNew^ do
              begin
                Name:=FirstNames[random(length(FirstNames))+1]+' '+LastNames[random(length(LastNames))+1];
                Address:=AddressSample[random(length(AddressSample))+1]+' '+inttostr(random(50));
                FixNumber:=1;
                while FixNumber<100000 do FixNumber:=random(999999);
                TelephoneNumber:=TelephoneNumberSample+'-'+inttostr(FixNumber);
                FixNumber:=1;
                while FixNumber<1000000 do FixNumber:=random(9999999);
                MobilePhoneNumber:=MobilePhoneNumberSample[random(length(MobilePhoneNumberSample))+1]+'-'+inttostr(FixNumber);
                NextData:=nil;
              end;
         if DatasFirst=nil then DatasFirst:=DatasNew
                           else DatasLast^.NextData:=DatasNew;
         DatasLast:=DatasNew;
      end;
end;

procedure WriteRandomDatas;
begin
  DatasTemp:=DatasFirst;
  while DatasTemp<>nil do
                       begin
                          with DatasTemp^ do
                               begin
                                  Writeln(Name:16,' ',Address:19,' ',TelephoneNumber:15,' ',MobilePhoneNumber:15);
                                end;
                          DatasTemp:=DatasTemp^.NextData;
                       end;
end;

procedure ReleaseRandomDatas;
begin
  DatasTemp:=DatasFirst;
  while DatasTemp<>nil do
                       begin
                          DatasFirst:=DatasTemp^.NextData;
                          dispose(DatasTemp);
                          DatasTemp:=DatasFirst;
                       end;
end;

procedure AskData;
begin
  with Datas do
       begin
          write(NameRequest);
          readln(Name);
          write(AddressRequest);
          readln(Address);
          write(TelephoneNumberRequest);
          readln(TelephoneNumber);
          write(MobilePhoneNumberRequest);
          readln(MobilePhoneNumber);
       end;
end;

procedure WriteData;
begin
  writeln;
  writeln;
  with Datas do
       begin
          writeln(Datas.Name);
          writeln(Datas.Address);
          writeln(Datas.TelephoneNumber);
          writeln(Datas.MobilePhoneNumber);
       end;
  writeln;
end;

procedure CreateFile;
var
  HowMany,Temp:integer;
  FixNumber:longint;
  ReadFileName,LineRead:string;
  FileName:textfile;
  Name,Address, TelephoneNumber,MobilePhoneNumber:string;
begin
  write('A file neve?: ');
  readln(ReadFileName);
  write('Mennyi rekordot hozzak letre?: ');
  readln(HowMany);
  assignfile(FileName,ReadFileName);
  rewrite(FileName);
  for Temp:=1 to HowMany do
      begin
        Name:=FirstNames[random(length(FirstNames))+1]+' '+LastNames[random(length(LastNames))+1];
        Address:=AddressSample[random(length(AddressSample))+1]+' '+inttostr(random(50));
        FixNumber:=1;
        while FixNumber<100000 do FixNumber:=random(999999);
        TelephoneNumber:=TelephoneNumberSample+'-'+inttostr(FixNumber);
        FixNumber:=1;
        while FixNumber<1000000 do FixNumber:=random(9999999);
        MobilePhoneNumber:=MobilePhoneNumberSample[random(length(MobilePhoneNumberSample))+1]+'-'+inttostr(FixNumber);
        writeln(FileName,Name,' ',Address,' ',TelephoneNumber,' ',MobilePhoneNumber);
      end;
  close(FileName);
end;

procedure ReadFile;
var
  ReadFileName:string;
  FileName:textfile;
  Datas:string;
  Temp:longint;
begin
  HowManyRows:=0;
  gotoxy(1,10);
  write('Mi a fajl neve?: ');
  readln(ReadFileName);
  assign(FileName,ReadFileName);
  reset(FileName);
  while not eof(FileName) do
                       begin
                         readln(FileName,Datas);
                         inc(HowManyRows);
                       end;
  setlength(HowManyArray,HowManyRows);
  close(FileName);
  reset(FileName);
  Temp:=0;
  while not eof(FileName) do
                       begin
                         readln(FileName,HowManyArray[Temp]);
                         inc(Temp);
                       end;
  close(FileName);
end;

procedure WriteArray;
var
  WichLine:longint;
begin
  gotoxy(1,1);
  write('                                                                   ');
  gotoxy(1,1);
  write('Melyik sort irjam ki (',HowManyRows,')?: ');
  readln(WichLine);
  gotoxy(1,3);
  write('                                                                   ');
  gotoxy(1,3);
  if (WichLine<=HowManyRows) and (WichLine<>0) then
     begin
       write(HowManyArray[WichLine-1]);
       repeat
           gotoxy(1,3);
           write('                                                                   ');
           gotoxy(1,3);
           write(HowManyArray[WichLine-1]);
           gotoxy(1,1);
           write('                                                                   ');
           gotoxy(1,1);
           write('Melyik sort irjam ki (',HowManyRows,')?: ');
           readln(WichLine);
       until (WichLine>HowManyRows) or (WichLine=0);
     end;
end;

function GetString(WorkString:string;var Position:integer):string;
begin
  GetString:='';
  while (WorkString[Position]<>#32) and (Position<>length(WorkString)+1) do
                       begin
                         GetString:=GetString+WorkString[Position];
                         inc(Position);
                       end;
  inc(Position);
end;

procedure WriteDataRecords;
var
  Temp2,Temp3,Temp4:integer;
  Street1:string;
begin
  setlength(DataRecords,HowManyRows);
  for Temp4:=0 to HowManyRows-1 do
      begin
        Temp3:=1;
        Temp2:=1;
        with DataRecords[Temp4] do
             begin
                repeat
                  Street1:=GetString(HowManyArray[Temp4],Temp2);
                  if Temp3=1 then Name:=Street1+' ';
                  if Temp3=2 then Name:=Name+Street1;
                  if Temp3=3 then Addr:=Street1+' ';
                  if Temp3=4 then Addr:=Addr+Street1+' ';
                  if Temp3=5 then Addr:=Addr+Street1;
                  If Temp3=6 then Tel:=Street1;
                  If Temp3=7 then MTel:=Street1;
                  inc(Temp3);
              until Temp2>length(HowManyArray[Temp4]);
            end;
      end;
  clrscr;
  write('Melyik rekordot mutassam meg ',HowManyRows,'?: ');
  readln(Temp4);
  repeat
    clrscr;
    gotoxy(1,5);
    writeln(DataRecords[Temp4-1].Name);
    writeln(DataRecords[Temp4-1].Addr);
    writeln(DataRecords[Temp4-1].Tel);
    writeln(DataRecords[Temp4-1].MTel);
    writeln;
    writeln(HowManyArray[Temp4-1]);
    gotoxy(1,1);
    write('Melyik rekordot mutassam meg ',HowManyRows,'?: ');
    readln(Temp4);
  until Temp4=0;
end;

begin
  clrscr;
  //CreateFile;
  //WriteArray;
  ReadFile;
  WriteDataRecords;
end.
