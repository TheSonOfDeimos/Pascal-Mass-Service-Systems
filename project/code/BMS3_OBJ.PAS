unit bms3_obj;
interface
uses types, crt;

type
bms3 = object
   constructor init;
	 procedure identify_NOMBUF(var nombuf:buff);
	 procedure shift_call(nombuf:buff);
	 procedure buff_modif(nombuf:buff; var ob, indbuf:buff);
	 procedure service(var tosv, lambdao:real; var counts, counts1, counts2:count; ob:buff);
	 procedure main(var nombuf:buff; var tosv, lambdao:real; var  counts, counts1, counts2:count; var ob, indbuf:buff);
end;


implementation

  procedure bms3.identify_NOMBUF(var nombuf:buff);
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

  procedure bms3.shift_call(nombuf:buff);

            begin
                 while nombuf^.prev <> nil do begin
                     nombuf^.buft:= nombuf^.prev^.buft;
                     nombuf^.bufn:= nombuf^.prev^.bufn;
                     nombuf:= nombuf^.prev;
                 end;
                 nombuf^.buft:= 0;
                 nombuf^.bufn:= 0;

            end;

  procedure bms3.buff_modif(nombuf:buff; var ob, indbuf:buff);

            begin

                 identify_nombuf(nombuf);

                 ob^.bufn:= nombuf^.bufn;
                 ob^.buft:= nombuf^.buft;
                 shift_call(nombuf);
                 indbuf:= indbuf^.next;
            end;

  procedure bms3.service(var tosv, lambdao:real; var counts, counts1, counts2:count; ob:buff);
  	var r1, r2:real;
        tayob:real ;

  	begin

  		randomize;
  		r1:= random;
  		r2:= random;
    	tayob:= -1 / lambdao * ln(r1 * r2);
      counts.tog:= counts.tog + (tosv - ob^.buft);

      if ob^.bufn = 1 then begin
        counts1.tog:= counts1.tog + (tosv - ob^.buft);
      end;
      if ob^.bufn = 2 then begin
        counts2.tog:= counts2.tog + (tosv - ob^.buft);
      end;
      tosv:= tosv + tayob;
  		counts.kolobr:= counts.kolobr + 1;

      if ob^.bufn = 1 then begin
        counts1.kolobr:= counts1.kolobr + 1;
      end;
      if ob^.bufn = 2 then begin
        counts2.kolobr:= counts2.kolobr + 1;
      end;

  	end;

  procedure bms3.main(var nombuf:buff; var tosv, lambdao:real; var  counts, counts1, counts2:count; var ob, indbuf:buff);
  	begin
  		buff_modif(nombuf, ob, indbuf);
  		service(tosv, lambdao, counts, counts1, counts2, ob);
  	end;

  constructor bms3.init;
              begin
              end;


end.
