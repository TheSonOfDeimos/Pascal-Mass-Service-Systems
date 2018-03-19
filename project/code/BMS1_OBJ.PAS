unit bms1_obj;
interface
uses types;

type
  bms1 = object
    constructor init;
  	procedure forming_KOTK(var counts, counts1, counts2:count; elem:call);
  	procedure gen_next_call(var elem:call);
  	procedure main(var elem:call;  var counts, counts1, counts2:count);
  end;


implementation
  procedure bms1.forming_kotk(var counts, counts1, counts2:count; elem:call);
  		begin
  			counts.kotk:= counts.kotk + 1;
        if elem.nmin = 1 then begin
          counts1.kotk:= counts1.kotk + 1;
        end
        else begin
          counts2.kotk:= counts2.kotk + 1;
        end;
  	  end;

  procedure bms1.gen_next_call(var elem:call);
         var  r:REAL;
              tay:real;

         begin

              
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

  procedure bms1.main(var elem:call; var counts, counts1, counts2:count);
    	begin
    		forming_kotk(counts, counts1, counts2, elem);
    		gen_next_call(elem);
    		counts.kol:= counts.kol + 1;

        if elem.nmin = 1 then begin
          counts1.kol:= counts1.kol + 1;
        end
        else begin
          counts2.kol:= counts2.kol + 1;
        end;

       end;

  constructor bms1.init;
            begin
            end;
      end.
