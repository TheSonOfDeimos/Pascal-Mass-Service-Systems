uses crt, bms2_obj, bms1_obj, types;

procedure buff_create(var head:buff; var tail:buff);
          var x:buff;
              i:integer;
          begin
             new(head);
             head^.next:= nil;
             head^.prev:= nil;
             x:= head;
             x^.bufn:= 0;
             x^.buft:= 0;
             for i:= 0 to 2 do begin
                 new(x^.next);
                 x^.next^.prev:= x;
                 x:= x^.next;
                 x^.next:= nil;
                 x^.bufn:= 0;
                 x^.buft:= 0;

             end;
             tail:= x;


          end;

procedure buff_write(head: buff; tail: buff);
          begin
               while head <> nil do begin
                     writeln(head^.bufn, ' --- ', head^.buft:10:5);
                     head:= head^.next;
               end;
          end;





var
    bms12:bms2;
    bms11:bms1;
    indbuf, head, tail:buff;
    elem:call;
    lambda:real;
    kol, kotk:integer;



begin
     buff_create(head, tail);



     lambda:= 1;
     elem.nmin:= 2;
     elem.tpost:= 0;
     indbuf:= tail^.prev^.prev;
     bms12.init;
     bms12.main(indbuf, elem, lambda, kol);
     buff_write(head, tail);
     writeln(elem.tpost:10:5);
     writeln(kol);

     if indbuf^.prev = nil then
        bms11.main(elem, lambda, kol, kotk)
     else bms12.main(indbuf, elem, lambda, kol);
     buff_write(head, tail);
     writeln(kol);
     writeln(kotk);




end.