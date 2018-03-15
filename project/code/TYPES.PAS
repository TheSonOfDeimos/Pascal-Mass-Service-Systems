unit types;
interface



type BUFF = ^list;
     list = record
          bufn:integer;
          buft:real;
          bufp:integer;
          next:buff;
          prev:buff;
     end;

     call = record
          tpost:real;
          nmin:integer;
     end;

     count = record
          kol, kolobr, kotk:INTEGER;
          tog:REAL;
     end;


implementation

end.
