unit alg_obj;

interface

  uses
     boss_obj, types, graph, crt, tpko_obj;

  TYPE
    alg = object
      constructor init;
      procedure zerro(var counts, counts1, counts2:count;  var kolprev:INTEGER);
      procedure buff_create(var head:buff; var tail:buff);
      procedure simulateZERO(lambdaO:real; kmin, dynamORconst, mode, flag2:INTEGER);
      procedure simulateNOTZERO(lambdaO:real; kmin, dynamORconst, mode, flag2:INTEGER);
      procedure main(lambdao:REAL; kmin, dynamORconst, zeroing, flag2, mode:INTEGER);
    end;

implementation
  procedure alg.zerro(var counts, counts1, counts2:count; var kolprev:INTEGER);
    begin
      kolprev:= 0;

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

  procedure alg.simulateZERO(lambdaO:real; kmin, dynamORconst, mode, flag2:INTEGER);
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

      {implementation}
      buff_create(head, tail);
      indbuf:= tail;
      elem1.nmin:= 1;
      elem2.nmin:= 2;
      elem1.tpost:= 0;
      elem2.tpost:= 0;
      ORDENATE:= 0;
      zerro(counts, counts1, counts2, kolprev);
      tosv:= 0;
      for i:= 0 to 20 do begin

        {coords}
        if mode <> 1 then begin
          gr.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, mode, flag2);
        end;

        while counts.kol <> kmin do begin
          bos.main(elem1, elem2, kolprev, tosv, lambdaO, indbuf, tail, ob, counts, counts1, counts2);

          {conditions}
          if counts.kol <> prevVAl then begin
            if ((counts.kol mod round((kmin / 560) * 21) = 0) and (mode = 2)) then begin
              ORDENATE:= ORDENATE + 1;
            end;
            if mode = 0 then begin
              if (counts.kol mod round(kmin / 560) = 0)then begin
                ORDENATE:= ORDENATE + 1;
              end;

              {might be }
              if counts.kol mod round(kmin / (560 - (kmin / round(kmin / 560)))) = 1 then begin
                ORDENATE:= ORDENATE + 1;
              end;
            end;

            prevVAL:= counts.kol;
          end;


          gr.DrawPointZERO(counts, ORDENATE, mode, flag2);


        end;
        write(output_t, counts, counts1, counts2);
        if (mode = 0) and (i < 20) then begin
          ORDENATE:= 0;
          gr.SimulationInfo(counts, counts1, counts2, lambdao, flag2);
          bot:= readkey;
          ClearViewPort;
        end;
        {zerroing}
        if i < 20 then begin
          zerro(counts, counts1, counts2, kolprev);
        end;
        {incremetation}
        if dynamORconst = 1 then begin
          lambdao:= lambdaO + 0.1;
        end;
      end;
      close(output_t);
      if mode <> 1 then begin
        gr.SimulationInfo(counts, counts1, counts2, lambdao, flag2);
        bot:= readkey;
      end;

    end;

  procedure alg.simulateNOTZERO(lambdaO:real; kmin, dynamORconst, mode, flag2:INTEGER);
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


        {implementation}
        buff_create(head, tail);
        indbuf:= tail;
        elem1.nmin:= 1;
        elem2.nmin:= 2;
        elem1.tpost:= 0;
        elem2.tpost:= 0;
        ORDENATE:= 0;
        zerro(counts, counts1, counts2, kolprev);
        tosv:= 0;
        for i:= 0 to 20 do begin

          {coords}
          if mode <> 1 then begin
            gr.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, mode, flag2);
          end;

          while counts.kol <> kmin * (i + 1) do begin
            bos.main(elem1, elem2, kolprev, tosv, lambdaO, indbuf, tail, ob, counts, counts1, counts2);

            {conditions}
            if counts.kol <> prevVAl then begin
              if (counts.kol mod round((kmin / 560) * 21) = 0) and (mode = 2)then begin
                ORDENATE:= ORDENATE + 1;
              end;
              if mode = 0 then begin
                if (counts.kol mod round(kmin / 560) = 0)then begin
                  ORDENATE:= ORDENATE + 1;
                end;
                {might be deleted}
                if counts.kol mod round(kmin / (560 - (kmin / round(kmin / 560)))) = 1 then begin
                  ORDENATE:= ORDENATE + 1;
                end;
              end;
              prevVAL:= counts.kol;
            end;


            gr.DrawPointZERO(counts, ORDENATE, mode, flag2);


          end;

          {output}

          write(output_t, counts, counts1, counts2);
          if (mode = 0) and (i < 20) then begin
            ORDENATE:= 0;
            gr.SimulationInfo(counts, counts1, counts2, lambdao, flag2);
            bot:= readkey;
            ClearViewPort;
          end;
          {zerroing}

          {incremetation}
          if dynamORconst = 1 then begin
            lambdao:= lambdaO + 0.1;
          end;


        end;
        close(output_t);
        if mode <> 1 then begin
          gr.SimulationInfo(counts, counts1, counts2, lambdao, flag2);
          bot:= readkey;
        end;
    end;

  procedure alg.main(lambdao:REAL; kmin, dynamORconst, zeroing, flag2, mode:INTEGER);
    begin

      if zeroing = 1 then begin
        simulateZERO(lambdaO, kmin, dynamORconst, mode, flag2);
      end;
      if zeroing = 0 then begin
        simulateNOTZERO(lambdaO, kmin, dynamORconst, mode, flag2);
      end;

    end;

  constructor alg.init;
    begin
    end;

end.
