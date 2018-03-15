uses crt;
type BUFF = ^list;
     list = record
          bufn:integer;
          buft:real;
          next:buff;
          prev:buff;
     end;

     call = record
          tpost:real;
          nmin:integer;
     end;




procedure gen_next_call(var elem:call; lambda:real);
         var  r:integer;
              tay:real;

         begin
              if elem.nmin = 1 then begin
                 randomize;
                 r:= random(10) + 1;
                 tay:= 1 / lambda * ln(r);
              end
              else
                 randomize;
                 r:= random(10) + 1;
                 tay:= 1 / lambda * ln(r);

              elem.tpost:= elem.tpost + tay;

         end;

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



procedure buff_record_call(var indbuf:buff; elem:call);

          begin
              indbuf:= indbuf^.prev;
              indbuf^.bufn:= elem.nmin;
              indbuf^.buft:= elem.tpost;

          end;



procedure identify_NOMBUF(var nombuf:buff);
          var
             save1, save2:buff;
          begin
               save1:= nil;
               save2:= nil;
               while nombuf <> nil do begin
                     if ((nombuf^.bufn = 1) and (save1 = nil)) then
                        save1:= nombuf
                     else if ((save2 = nil) and (nombuf^.bufn = 2)) then
                        save2:= nombuf;
                     nombuf:= nombuf^.prev;
               end;
               if save1 <> nil then
                  nombuf:= save1
               else nombuf:= save2;
          end;



procedure shift_call(nombuf:buff);

          begin
               while nombuf <> nil do begin
                   nombuf^.buft:= nombuf^.prev^.buft;
                   nombuf^.bufn:= nombuf^.prev^.bufn;
                   nombuf:= nombuf^.prev;
               end;
               nombuf^.buft:= 0;
               nombuf^.bufn:= 0;

          end;

procedure buff_modif(nombuf:buff; var ob:buff);

          begin

               identify_nombuf(nombuf);
               new(ob);
               ob^.bufn:= nombuf^.bufn;
               ob^.buft:= nombuf^.buft;
               shift_call(nombuf);
          end;


var
   lambda, tpost:real;
   nmin:integer;
   elem:call;

   head, tail, indbuf, nombuf:buff;

begin
     elem.tpost:= 23;
     lambda:= 1;
     elem.nmin:= 2;
     gen_next_call(elem, lambda);


     buff_create(head, tail);

     indbuf:= tail;
     nombuf:= tail;

     buff_record_call(indbuf, elem);
     buff_write(head, tail);
     identify_nombuf(nombuf);
     writeln(nombuf^.bufn);
end.