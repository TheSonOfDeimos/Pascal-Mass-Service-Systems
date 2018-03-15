uses crt, bms3_obj, bms4_obj, types;

procedure buff_create(var head:buff; var tail:buff);
          var x:buff;
              i:integer;
          begin
             new(head);
             head^.next:= nil;
             head^.prev:= nil;
             x:= head;
             randomize;
             x^.bufn:= random(2) + 1;
             x^.buft:= random(20);
             for i:= 0 to 1 do begin
                 new(x^.next);
                 x^.next^.prev:= x;
                 x:= x^.next;
                 x^.next:= nil;
                 x^.bufn:= random(2) + 1;
                 x^.buft:= random(20);
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
    bms31:bms3;
    bms32:bms4;
    head,tail:buff;
    elem:call;
    tosv, lambda:real;
    kolobr:integer;
    indbuf:buff;

    nombuf:buff;
    tog:real;
    ob:buff;






begin

     buff_create(head, tail);
     buff_write(head, tail);
     lambda:= 2;
     nombuf:= tail;
     bms31.init;
     bms31.main(nombuf, tog, tosv, lambda, kolobr, ob);
     writeln(ob^.bufn, '+++', ob^.buft:10:5);
     buff_write(head, tail);
     writeln(kolobr);
     writeln(tog);
     writeln(tosv);

     nombuf:= tail;
     indbuf:= nil;




     if indbuf = nil then
        bms32.main(elem, tosv, lambda, kolobr)
     else bms31.main(nombuf, tog, tosv, lambda, kolobr, ob);




     writeln(elem.tpost:10:5);
     writeln(ob^.bufn, '+++', ob^.buft:10:5);
     buff_write(head, tail);
     writeln(kolobr);
     writeln(tog);
     writeln(tosv);



end.
