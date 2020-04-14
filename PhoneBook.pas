program PhoneBook;

uses crt,sysutils;

const
  NameRequest='Kerem a nevet: ';
  AddressRequest='Kerem a cimet: ';
  TelephoneNumberRequest='Kerem a telefonszamot: ';
  MobilePhoneNumberRequest='Kerem a mobiltelefonszamot: ';
  ExitString='Nyomj egy ENTER-t a kilepeshez!';

  FirstNames:array [1..5] of string = ('Nagy','Kis','Toth','Lakatos', 'Horvath');
  LastNames:array [1..5] of string = ('Janos','Andrea','Levente','Cecilia','Robert');
  AddressSample:array [1..5] of string =('Bem utca','Liliom ter','Arpad ut','Hajnal utca','Mikszath korut');
  TelephoneNumberSample:word = (642);
  MobilePhoneNumberSample:array [1..2] of word = (630,670);

type
  PDatas=^RDatas;
  RDatas=record
         Name:string;
         Address:string;
         TelephoneNumber:string;
         MobilePhoneNumber:string;
         NextData:PDatas;
        end;

var
  Datas:RDatas;
  DatasFirst, DatasLast, DatasNew, DatasTemp:PDatas;
  ExitNumber:byte;

procedure FillDatas;
var
  HowMuch:byte;
  FixNumber:longint;
begin
  for HowMuch:=1 to 15 do
      begin
         new(DatasNew);
         with DatasNew^ do
              begin
                Name:=FirstNames[random(length(FirstNames))+1]+' '+LastNames[random(length(LastNames))+1];
                Address:=AddressSample[random(length(AddressSample))+1]+' '+inttostr(random(50));
                FixNumber:=1;
                while FixNumber<100000 do FixNumber:=random(999999);
                TelephoneNumber:='0'+inttostr(TelephoneNumberSample)+'-'+inttostr(random(FixNumber));
                FixNumber:=1;
                while FixNumber<100000 do FixNumber:=random(999999);
                MobilePhoneNumber:='0'+inttostr(MobilePhoneNumberSample[random(length(MobilePhoneNumberSample))+1])+'-'+inttostr(FixNumber);
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
                                  Writeln(Name:15,' ',Address:20,' ',TelephoneNumber:15,' ',MobilePhoneNumber:15);
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

begin
  //AskData;
  //WriteData;
  randomize;
  repeat
    clrscr;
    FillDatas;
    WriteRandomDatas;
    ReleaseRandomDatas;
    writeln;
    //write(ExitString);
    writeln('0 - Exit');
    readln(ExitNumber);
  until ExitNumber=0;
end.
