program PhoneBook;

const
  NameRequest='K‚rem a nevet: ';
  AddressRequest='K‚rem a c¡met: ';
  TelephoneNumberRequest='K‚rem a telefonsz mot: ';
  MobilePhoneNumberRequest='K‚rem a mobiltelefon sz mot: ';
  ExitString='Nyomj egy ENTER-t a kil‚p‚shez!';

var
  Datas:record
        Name:string;
        Address:string;
        TelephoneNumber:string;
        MobilPhoneNumber:string;
        end;

begin
  write(NameRequest);
  readln(Datas.Name);
  write(AddressRequest);
  readln(Datas.Address);
  write(TelephoneNumberRequest);
  readln(Datas.TelephoneNumber);
  write(MobilePhoneNumberRequest);
  readln(Datas.MobilPhoneNumber);
  writeln;
  writeln;
  writeln(Datas.Name);
  writeln(Datas.Address);
  writeln(Datas.TelephoneNumber);
  writeln(Datas.MobilPhoneNumber);
  writeln;
  writeln(ExitString);
  readln;
end.
