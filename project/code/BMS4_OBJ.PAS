unit bms4_obj;
interface
uses types;

type
bms4 = object
   constructor init;
	 procedure forming_tosv(var tosv, lambdaO:REAL);
	 procedure gen_next_call(var elem:call);
	 procedure main(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count);
end;


implementation

  procedure bms4.forming_tosv(var tosv, lambdaO:real);
  	var r1, r2:REAL;
        		tayob:real ;
  	begin

  		randomize;
  		r1:= random;
  		r2:= random;
  		tayob:= - 1 / lambdaO * ln(r1 * r2);
  		tosv:= tosv + tayob;

  	end;

  procedure bms4.gen_next_call(var elem:call);
           var  r:REAL;
                tay:real;

           begin
             randomize;
             if elem.nmin = 1 then begin
               r:= random;
               tay:= -1 / 2 * ln(r);
               elem.tpost:= elem.tpost + tay;
             end;
             if elem.nmin = 2  then begin
               r:= random;
               tay:= -1 / 3 * ln(r);
               elem.tpost:= elem.tpost + tay;
             end;


           end;

  procedure bms4.main(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count);
  	begin
  		forming_tosv(tosv, lambdaO);
  		gen_next_call(elem);
      counts.kol:= counts.kol + 1;

      if elem.nmin = 1 then begin
        counts1.kol:= counts1.kol + 1;
      end
      else begin
        counts2.kol:= counts2.kol + 1;
      end;

  	end;

  constructor bms4.init;
              begin
              end;


end.
