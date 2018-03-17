unit boss_obj;
interface
uses types, bms1_obj, bms2_obj, bms3_obj, bms4_obj;

type
  boss = object
  	constructor init;
	  procedure bas12(var elem:call; var counts, counts1, counts2:count; var indbuf:buff);
	  procedure bas3(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count; var nombuf, indbuf, ob:buff);
    procedure main(var elem1, elem2:call; var  kolprev:INTEGER; var tosv:real; lambdaO:real;
              var indbuf, tail, ob:buff; var counts, counts1, counts2:count);

  end;


implementation

  procedure boss.bas12(var elem:call; var counts, counts1, counts2:count; var indbuf:buff);
    var
      bm1	: bms1;
  	  bm2	: bms2;
  	begin
  		if indbuf^.prev = nil then
          		bm1.main(elem, counts, counts1, counts2)
      else
  			      bm2.main(indbuf, elem, counts, counts1, counts2);

  	end;

  procedure boss.bas3(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count; var nombuf, indbuf, ob:buff);
          var
             bm4	: bms4;
  	         bm3	: bms3;
            begin
            	if indbuf^.bufn = 0 then
            		bm4.main(elem, tosv, lambdaO, counts, counts1, counts2)
            	else
  			        bm3.main(nombuf, tosv, lambdaO, counts, counts1, counts2, ob, indbuf);
            end;

  procedure boss.main(var elem1, elem2:call; var  kolprev:INTEGER; var tosv:real; lambdaO:real;
            var indbuf, tail, ob:buff; var counts, counts1, counts2:count);
  	var
  		elem:call;
  		nombuf:buff;

  	begin


  		if elem1.tpost < elem2.tpost then begin
  			 elem.tpost:= elem1.tpost;
  			 elem.nmin:= elem1.nmin;
  		end
  		else begin
  			elem.tpost:= elem2.tpost;
  			elem.nmin:= elem2.nmin;
  		end;

  		nombuf:= tail^.prev;
  		if tosv <= elem.tpost then
  			bas3(elem, tosv, lambdaO, counts, counts1, counts2, nombuf, indbuf, ob)
  		else
  			bas12(elem, counts, counts1, counts2, indbuf);

      if counts.kolobr <> kolprev then begin
        counts.request:= counts.request + indbuf^.bufp;
        kolprev:= counts.kolobr;
      end;


      if elem.nmin = 1 then begin
        elem1.tpost:= elem.tpost;
        elem1.nmin:= elem.nmin;
      end
      else begin
        elem2.tpost:= elem.tpost;
        elem2.nmin:= elem.nmin;
      end;



  	end;

  constructor boss.init;
              begin
              end;

end.
