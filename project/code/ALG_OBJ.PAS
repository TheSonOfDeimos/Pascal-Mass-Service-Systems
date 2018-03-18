unit alg_obj;

interface

  uses
     boss_obj, types, graph, crt, tpko_obj;

  TYPE
    alg = object
      constructor init;
      procedure zerro(var counts, counts1, counts2:count;  var kolprev:INTEGER; var tosv:real);
      procedure buff_create(var head:buff; var tail:buff);
      procedure alg.simulateZERO(lambdaO:real; kmin, mode, flag2:INTEGER);
      procedure main(lambdaO:real; kolsum, flag2, zeroing, dynamORconst:INTEGER);
    end;

implementation
  procedure alg.zerro(var counts, counts1, counts2:count; var kolprev:INTEGER; var tosv:real);
    begin
      kolprev:= 0;
      tosv:= 0;

      {ALL}
      counts.kol:= 0;
      counts.kolobr:= 0;
      counts.kotk:= 0;
      counts.tog:= 0;
      counts.request:= 0;

      {1 CALL}
      counts1.kol:= 0;
      counts1.kolobr:= 0;
      counts1.kotk:= 0;
      counts1.tog:= 0;
      counts1.request:= 0;

      {2 CALL}
      counts2.kol:= 0;
      counts2.kolobr:= 0;
      counts2.kotk:= 0;
      counts2.tog:= 0;
      counts2.request:= 0;

    end;

  procedure alg.buff_create(var head:buff; var tail:buff);
            var
                x:buff;
                i:integer;
            begin
               new(head);
               head^.next:= nil;
               head^.prev:= nil;
               x:= head;
               randomize;
               x^.bufn:= 0;
               x^.buft:= 0;
               x^.bufp:= 4;
               for i:= 0 to 3 do begin
                   new(x^.next);
                   x^.next^.prev:= x;
                   x:= x^.next;
                   x^.next:= nil;
                   x^.bufn:= 0;
                   x^.buft:= 0;
                   x^.bufp:= 3 - i;
               end;
               tail:= x;
            end;

  procedure alg.simulateZERO(lambdaO:real; kmin, mode, flag2:INTEGER);
    var
      {my types}
      counts, counts1, counts2 : count;
      output_t : file of count;
      head, tail, indbuf, ob : buff;
      elem1, elem2 : call;
      {deafolt types}
      i , kolprev, ORDENATE, prevVAL: INTEGER;
      tosv : real;
      bot : STRING;
      {objects types}
      gr : graphik;
      bos : boss;

    begin
      assign(output_t, 'typedoutp.txt');
      rewrite(output_t);
      gr.coordinates();
      {implementation}
      buff_create(head, tail);
      indbuf:= tail;
      elem1.nmin:= 1;
      elem2.nmin:= 2;
      elem1.tpost:= 0;
      elem2.tpost:= 0;

      for i:= 0 to 20 do begin
        while counts.kol <> kmin do begin
          bos.main(elem1, elem2, kolprev, tosv, lambdaO, indbuf, tail, ob, counts, counts1, counts2);

          {conditions}
          if counts.kal <> prevVAl then begin
            if (counts.kol mod round((kmin / 560) * 21)) and (mode = 2)then begin
              ORDENATE:= ORDENATE + 1;
            end;
            if (counts.kol mod round(kmin / 560)) and (mode = 0)then begin
              ORDENATE:= ORDENATE + 1;
            end;
            prevVAL:= counts.kal;
          end;

          gr.DrawPointZERO(counts, counts1, counts2, ORDENATE, mode, flag2);

        end;

        {output}
        write(output_t, counts, counts1, counts2);
        if mode = 0 then begin
          bot:= readkey;
        end;
        {zerroing}
        zerro(counts, counts1, counts2, kolprev, tosv);
        {incremetation}
        lambdao:= lambdaO + 0.1;
        end;
      end;
      
      close(output_t);
      bot:= readkey;
    end;

  procedure alg.main(lambdaO:real; kolsum, flag2, zeroing, dynamORconst:INTEGER);
    var
        gr:graphik;
        bos:boss;
        head, tail, indbuf, ob:buff;
        elem1, elem2:call;
        counts, counts1, counts2:count;
        kolprev, kolprevious, i, save, b: integer;
        req_in_buf:LONGINT;
        tosv: real;
        j:STRING;
        output:text;
        typedoutp: file of count;
    begin

      zerro(counts, counts1, counts2, elem1, elem2, kolprev, tosv);
      buff_create(head, tail);
      indbuf:= tail;

      if lambdao = 0 then
         lambdao:= 1;

      assign(typedoutp, 'typedoutp.txt');
      rewrite(typedoutp);

      gr.coordinates(45, 440, 'numUP'); {Draw axes}
      for i:= 1 to 21 do begin

        if zeroing = 0 then begin
          while counts.kol <> kolsum * i do begin
            bos.main(elem1, elem2, kolprev, tosv, lambdaO, indbuf, tail, ob, counts, counts1, counts2);
            gr.DrawPoint(counts, kolsum * 21, flag2);
          end;
        end;

        if zeroing = 1 then begin
          ClearViewPort;
          gr.coordinates(45, 440, 'numUP'); {Draw axes}
          for b:= 1 to 21 do begin
            while counts.kol <> kolsum * b do begin
              bos.main(elem1, elem2, kolprev, tosv, lambdaO, indbuf, tail, ob, counts, counts1, counts2);
              gr.DrawPoint(counts, kolsum * 21, flag2);
            end;
          end;

        end;



        write(typedoutp, counts, counts1, counts2);

        if dynamORconst = 1 then begin
          lambdaO:= lambdaO + 0.1;
        end;

        if zeroing = 1 then begin
          dispose(head);
          Dispose(tail);
          zerro(counts, counts1, counts2, elem1, elem2, kolprev, tosv);
          buff_create(head, tail);
          indbuf:= tail;
        end;
      end;


      close(typedoutp);
      if counts.kolobr = 0 then
         counts.kolobr:= 1;

      {cout results}
      case flag2 of
        0: gr.simulationINFO(counts.tog, indbuf, ob, counts.kol , counts.kotk, counts.kolobr , 0);
        1: gr.simulationINFO(counts.tog, indbuf, ob, counts.kol , counts.kotk, counts.kolobr , 1);
        2: gr.simulationINFO(counts.tog, indbuf, ob, counts.kol , counts.kotk, counts.kolobr , 2);
      end;


      j:= readkey;
    end;

  constructor alg.init;
    begin
    end;

end.
