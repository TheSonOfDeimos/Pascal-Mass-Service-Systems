uses crt, bms2_obj, types;

procedure buff_create(var head:buff; var tail:buff);
          var x:buff;
              i:integer;
          begin
             new(head);
             head^.next:= nil;
             head^.prev:= nil;
             x:= head;

             for i:= 0 to 1 do begin
                 new(x^.next);
                 x^.next^.prev:= x;
                 x:= x^.next;
                 x^.next:= nil;


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
    indbuf, head, tail:buff;
    elem:call;
    lambda:real;
    kol:integer;



begin
     buff_create(head, tail);
     buff_write(head, tail);


     lambda:= 1;
     elem.nmin:= 3;
     indbuf:= tail;
     bms12.init;
     bms12.main(indbuf, elem, lambda, kol);

end.
