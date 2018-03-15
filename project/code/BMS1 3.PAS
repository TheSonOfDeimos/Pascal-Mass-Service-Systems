unit bms1_obj;
interface
uses types;

type
bms1 = object
  	constructor init;
	procedure forming_KOTK(var kotk:integer; elem:call);
	procedure gen_next_call(var elem:call; lambda:real);
	procedure main(var elem:call; lambda:real; var kol, kotk:integer);
   end;


implementation
	procedure bms1.forming_kotk(var kotk:integer; elem:call);
		begin
			kotk:= kotk + 1;

		end;

procedure bms1.gen_next_call(var elem:call; lambda:real);
         var  r:integer;
              tay:real;

         begin
              randomize;
              r:= random(10) + 1;
              tay:= 1 / lambda * ln(r);
              elem.tpost:= elem.tpost + tay;
         end;

procedure bms1.main(var elem:call; lambda:real; var kol, kotk:integer);
	begin
		forming_kotk(kotk, elem);
		gen_next_call(elem, lambda);
		kol:= kol + 1;

   end;

constructor bms1.init;
            begin
            end;
end.