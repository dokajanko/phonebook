program PhoneBook;

const
  NameRequest='K‚rem a nevet: ';
  AddressRequest='K‚rem a c¡met: ';
  TelephoneNumberRequest='K‚rem a telefonsz mot: ';
  MobilePhoneNumberRequest='K‚rem a mobiltelefon sz mot: ';
  ExitString='Nyomj egy ENTER-t a kil‚p‚shez!';

type
  RDatas=record
         Name:string;
         Address:string;
         TelephoneNumber:string;
         MobilPhoneNumber:string;
        end;

var
  Datas:RDatas;

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
          readln(MobilPhoneNumber);
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
          writeln(Datas.MobilPhoneNumber);
       end;
  writeln;
end;

begin
  AskData;
  WriteData;
  write(ExitString);
  readln;
end.
