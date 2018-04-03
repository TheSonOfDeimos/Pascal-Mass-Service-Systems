unit wind_obj;

interface

  uses
     crt, graph, tpko_obj, boss_obj, alg_obj, types;
  TYPE
    windows = object
      procedure PointingDot(ButN:integer; var flag:INTEGER; j:STRING);
      procedure drawbottom(alig,  elip, swich:INTEGER; nameBott:STRING);
      procedure mode(var tick:INTEGER);
      procedure values(var tick, tick2, kolsum:INTEGER; var lambdao:real);
      procedure meta(var tick:INTEGER);
      procedure table(dynamORconst:INTEGER; lambdao:REAL);
      procedure plot(kmin, dynamORconst:INTEGER; lambdaO:REAL);
      procedure main(flag, flag2:INTEGER;  var mode1, kolsum, zeroing, dynamORconst:INTEGER; var lambdao:REAL;
                 var lambdaofsourse:lambdaofS);
      constructor init(var tick:INTEGER);
    end;
implementation

  procedure windows.PointingDot(ButN:integer; var flag:INTEGER; j:STRING);
    begin

      if j = #80 then begin
         drawbottom(flag + 1, 1, 2, '');
         flag:= flag + 1;
      end;

      if (j = #72) and (flag <> -1) then begin
        drawbottom(flag + 1, 1, 2, '');
        flag:= flag - 1;
      end;

      if flag > ButN - 1 then
        flag:= flag - ButN;
      if flag < 0 then
        flag:= flag + ButN;

      if flag >= 0 then begin
         drawbottom(flag + 1, 1, 1, '');

      end;
    end;

  procedure windows.drawbottom(alig, elip, swich:INTEGER; nameBott:STRING);
    var x:INTEGER;
    begin

      if elip  = 1 then begin
        x:= 30;
        if swich = 0 then begin

          setcolor(7);
          Rectangle	(GetMaxX div 4, 100  + 60 * ALIG , GetMaxX div 4 * 3, 155 + 60 * alig);{don't change}
          SetFillStyle(SolidFill, 7);
          FloodFill(GetMaxX div 4 + 1, 101 + 60 * alig, 7);

          SetColor(8);
          settextstyle(0, horizDir, 3);
          outtextxy(GetMaxX div 3  - 20 + x, (118 + 60 * alig), nameBott);


          setFillStyle(SolidFill, 8);
          SetColor(8);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 12, 12);

          setFillStyle(SolidFill, 7);
          SetColor(7);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 10, 10);

          setFillStyle(SolidFill, 8);
          SetColor(8);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 8, 8);
        end;
        if swich = 1 then begin
          setFillStyle(SolidFill, 7);
          SetColor(7);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 6, 6);
        end;
        if swich = 2 then begin
          setFillStyle(SolidFill, 8);
          SetColor(8);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 6, 6);
        end;
      end
      else begin
        setcolor(8);
        Rectangle	(GetMaxX div 4, 100  + 60 * ALIG , GetMaxX div 4 * 3, 155 + 60 * alig);{don't change}
        SetFillStyle(SolidFill, 8);
        FloodFill(GetMaxX div 4 + 1, 101 + 60 * alig, 8);

        SetColor(7);
        settextstyle(0, horizDir, 3);
        outtextxy(GetMaxX div 3  + 20, (118 + 60 * alig)  , nameBott);
      end;
    end;

  procedure windows.mode(var tick:INTEGER);
    label start;
    var j:STRING;
        flag:INTEGER;
    begin
      flag:= -1;
      start:
      drawbottom(0, 0, 0, ' MODE');
      drawbottom(1, 1, 0, 'STEPPING');
      drawbottom(2, 1, 0, 'OFFLINE');
      drawbottom(3, 1, 0, 'ALL');

      repeat
        j:= readkey;
        if j <> #8 then begin
          PointingDot(3, flag, j);
          if j = #13 then begin
            tick:= flag;
            ClearViewPort;
            goto start;{MIGHT BE A MISTAKE... 123 is unic idetiyty cide fof each setting}
          end;
        end;
      until (j = #8);
    end;

  procedure windows.values(var tick, tick2, kolsum:INTEGER; var lambdao:real);
    label start;
    var j, bt, lam, ko:STRING;
        flag, i, n:INTEGER;
    begin
      flag:= -1;
      start:
      lam:= '';
      ko:= '';
      PointingDot(4, flag, j);
      drawbottom(0, 0, 0, ' VALUES');
      drawbottom(1, 1, 0, 'L CONST:');
      drawbottom(2, 1, 0, 'L DYNAM:');
      drawbottom(3, 1, 0, 'R VAL:');
      drawbottom(4, 1, 0, 'ZEROING');

      repeat
        j:= readkey;

        if j <> #8 then begin
          PointingDot(4, flag, j);
          i:= 0;
          if j = #13 then begin
            if (flag = 0) or (flag = 1) or (flag = 2) then begin
              repeat
                bt:= readkey;
                if bt <> #13 then begin
                  inc(i);
                  outtextXY((GetMaxX div 4  *  3) + (i * 25), (118 + 60 * (flag + 1)),bt);
                  if flag = 0  then begin
                    lam:= lam + bt;
                    val(lam, lambdao, n);
                    tick2:= 0;
                  end;
                  if  flag = 1 then begin
                    lam:= lam + bt;
                    val(lam, lambdao, n);
                    tick2:= 1;
                  end;
                  if flag  = 2 then begin
                    ko:= ko + bt;
                    val(ko, kolsum, n);
                  end;
                end;
              until (bt = #13);
              ClearViewPort;
              goto start;
            end;
            if (flag = 3) then begin
              tick:= (tick + 1) mod 2;

                {MIGHT BE A MISTAKE... 123 is unic idetiyty cide fof each setting}
              ClearViewPort;
              goto start;
            end;
          end;
        end;
      until (j = #8);
    end;

  procedure windows.meta(var tick:INTEGER);
    var
      readme:text;
      line, bt:STRING;
      align:INTEGER;
    begin
      setcolor(15);
      settextstyle(smallfont, horizDir, 5);
      assign(readme, 'meta.txt');
      reset(readme);
      align:= 50;
      while not eof(readme) do begin
        readln(readme, line);
        outtextXY(45, align, line);
        align:= align + 15;
      end;
      close(readme);
      bt:= readkey;
    end;

  procedure windows.table(dynamORconst:INTEGER; lambdao:REAL);
    var bt, line, P, WaiT, ReqB, step, Lam, save:STRING;
        n, align, kolobr:INTEGER;
        tpinput: file of count;
        counts:count;


    begin

      SetColor(15);

      assign(tpinput, 'typedoutp.txt');
      reset(tpinput);
      align:= 50;
      step:= '  ';
      Seek(tpinput, 0);
      settextstyle(2, horizDir, 5);
      outtextxy(20, align - 30, 'Lambda' + step + 'P(all)' +'  '+ step + 'P(1)' +'  '+ step + 'P(2)' + step +
                'WaiT(all)' + step + 'WaiT(1)' + step + 'WaiT(2)' + step +
                'RqB(all)' + step + 'RqB(1)'+ step + 'RqB(2)');
      settextstyle(2, horizDir, 5);
      while not eof(tpinput)  do begin

        str(lambdaO:5:1, Lam); {LAmbda}
        lam:= lam + ' ';
        {all}
        read(tpinput, counts);
        kolobr:= counts.kolobr;
        str((100 * (counts.kotk/(counts.kol + 1))):2:2, save); {P}
        P:= save + '%' + step;
        str((counts.tog/(counts.kolobr + 1)):3:2, save);{WaiT}
        WaiT:= save  + step;
        str((counts.request/(kolobr + 1)):3:2, save);{ReqB}
        ReqB:= save + step;

        {1}
        read(tpinput, counts);
        str((100 * (counts.kotk/(counts.kol + 1))):2:2, save); {P}
        P:= P + save + '%' + step;
        str((counts.tog/(counts.kolobr + 1)):3:2, save);{WaiT}
        WaiT:=  WaiT +'   '+ save + step;
        str((counts.request/(kolobr + 1)):3:2, save);{ReqB}
        ReqB:= ReqB +'   '+ save + step;

        {2}
        read(tpinput, counts);
        str((100 * (counts.kotk/(counts.kol + 1))):2:2, save); {P}
        P:= P + save + '%' + step;
        str((counts.tog/(counts.kolobr + 1)):3:2, save);{WaiT}
        WaiT:=  WaiT +'   '+ save + step;
        str((counts.request/(kolobr + 1)):3:2, save);{ReqB}
        ReqB:= ReqB +'  '+ save + step;

        line:= lam + step + P + WaiT + '  ' + ReqB;
        outtextxy(20, align, line);
        align:= align + 15;
        if dynamORconst = 1 then begin
          lambdaO:= lambdaO + 0.1;
        end;
      end;
      bt:= readkey;
      close(tpinput);

    end;

  procedure windows.plot(kmin, dynamORconst:INTEGER; lambdaO:REAL);
    var
       axe:graphik;
       bt, tab:STRING;
       i, res, res1, kolobr:INTEGER;
       counts:count;
       input: file of count;
    begin

      assign(input, 'typedoutp.txt');
      reset(input);

      {P all}
      axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 0);
      SetColor(15);
      setfillstyle(solidfill, 15);
      seek(input, 0);

      read(input, counts);
      Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
      read(input, counts);
      read(input, counts);
      for i:= 1 to 20 do begin
        read(input, counts);
        lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
        fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
        read(input, counts);
        read(input, counts);
      end;

      SetColor(15);

      res:= 0;
      res1:= 0;
      repeat
        settextstyle(2, horizDir, 5);
        SetColor(0);
        outtextXY(400, 45, 'Press <- or -> to choose');
        SetColor(15);
        outtextXY(400, 45, 'Press TAB to choose');
        tab:= readkey;
        if tab = #9 then begin
          res1:= res1 + 1;
        end;

        if res1 > 2 then begin
          res1:= 0;
        end;

        if  tab <> #8 then begin
          ClearViewPort;
            case res1 of
              0: begin
                      SetColor(15);
                      settextstyle(6, horizDir, 3);
                      outtextXY(45, 45, 'Rejections');
                      settextstyle(2, horizDir, 5);
                      outtextXY(400, 45, 'Press <- or -> to choose');
                      {P all}
                      axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 0);
                      SetColor(15);
                      setfillstyle(solidfill, 15);
                      seek(input, 0);

                      read(input, counts);
                      Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                      read(input, counts);
                      read(input, counts);
                      for i:= 1 to 20 do begin
                        read(input, counts);
                        lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                        fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                        read(input, counts);
                        read(input, counts);
                      end;
                      repeat
                        bt:= readkey;
                        if bt = #77 then begin
                          res:= res + 1;
                        end;

                        if bt = #75 then begin
                          res:= res - 1;
                        end;

                        if res > 2 then begin
                          res:= 0;
                        end;
                        if res < 0 then begin
                          res:= 2;
                        end;

                        if (bt = #77) or (bt = #75) then begin

                          SetColor(15);
                          settextstyle(6, horizDir, 3);
                          outtextXY(45, 45, 'Rejections (all)');
                          ClearViewPort;
                          settextstyle(2, horizDir, 5);
                          outtextXY(400, 45, 'Press <- or -> to choose');
                          axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 0);
                          case res of
                              0: begin
                                    {P all}
                                    settextstyle(6, horizDir, 3);
                                    outtextXY(45, 45, 'Rejections (all)');
                                    SetColor(15);
                                    setfillstyle(solidfill, 15);
                                    seek(input, 0);

                                    read(input, counts);
                                    Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                                    read(input, counts);
                                    read(input, counts);
                                    for i:= 1 to 20 do begin
                                      read(input, counts);
                                      lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                                      fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                                      read(input, counts);
                                      read(input, counts);
                                    end;
                                  end;
                              1: begin
                                    {p1}
                                    settextstyle(6, horizDir, 3);
                                    outtextXY(45, 45, 'Rejections (1)');
                                    SetColor(2);
                                    setfillstyle(solidfill, 2);
                                    seek(input, 0);
                                    read(input, counts);
                                    read(input, counts);
                                    Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                                    read(input, counts);
                                    for i:= 1 to 20 do begin
                                      read(input, counts);
                                      read(input, counts);
                                      lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                                      fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                                      read(input, counts);
                                    end;
                                  end;
                                    {p2}
                              2: begin
                                      settextstyle(6, horizDir, 3);
                                      outtextXY(45, 45, 'Rejections (2)');
                                      SetColor(4);
                                      setfillstyle(solidfill, 4);
                                      seek(input, 0);
                                      read(input, counts);
                                      read(input, counts);
                                      read(input, counts);
                                      Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                                      for i:= 1 to 20 do begin
                                        read(input, counts);
                                        read(input, counts);
                                        read(input, counts);
                                        lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                                        fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                                      end;
                                  end;
                                end;
                          end;
                      until (bt = #9);
                   end;
              1: begin
                      SetColor(15);
                      settextstyle(6, horizDir, 3);
                      outtextXY(45, 45, 'Witing time');
                      settextstyle(2, horizDir, 5);
                      outtextXY(400, 45, 'Press <- or -> to choose');
                      {P all}
                      axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 1);
                      SetColor(15);
                      setfillstyle(solidfill, 15);
                      seek(input, 0);

                      read(input, counts);
                      Moveto(45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                      read(input, counts);
                      read(input, counts);
                      for i:= 1 to 20 do begin
                        read(input, counts);
                        lineto(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                        fillEllipse(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74), 2, 2);
                        read(input, counts);
                        read(input, counts);
                      end;
                      repeat
                         bt:= readkey;
                         if bt = #77 then begin
                           res:= res + 1;
                         end;

                         if bt = #75 then begin
                           res:= res - 1;
                         end;

                         if res > 2 then begin
                           res:= 0;
                         end;
                         if res < 0 then begin
                           res:= 2;
                         end;

                         if (bt = #77) or (bt = #75) then begin

                           SetColor(15);
                           settextstyle(6, horizDir, 3);
                           outtextXY(45, 45, 'Witing time (all)');
                           ClearViewPort;
                           settextstyle(2, horizDir, 5);
                           outtextXY(400, 45, 'Press <- or -> to choose');

                           axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 1);
                           case res of
                               0: begin
                                     {P all}
                                     settextstyle(6, horizDir, 3);
                                     outtextXY(45, 45, 'Witing time (all)');
                                     SetColor(15);
                                     setfillstyle(solidfill, 15);
                                     seek(input, 0);

                                     read(input, counts);
                                     Moveto(45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                                     read(input, counts);
                                     read(input, counts);
                                     for i:= 1 to 20 do begin
                                       read(input, counts);
                                       lineto(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.742));
                                       fillEllipse(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74), 2, 2);
                                       read(input, counts);
                                       read(input, counts);
                                     end;
                                  end;
                               1: begin
                                     {p1}
                                     settextstyle(6, horizDir, 3);
                                     outtextXY(45, 45, 'Witing time (1)');
                                     SetColor(2);
                                     setfillstyle(solidfill, 2);
                                     seek(input, 0);
                                     read(input, counts);
                                     read(input, counts);
                                     Moveto(45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                                     read(input, counts);
                                     for i:= 1 to 20 do begin
                                       read(input, counts);
                                       read(input, counts);
                                       lineto(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                                       fillEllipse(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74), 2, 2);
                                       read(input, counts);
                                     end;
                                   end;
                                     {p2}
                               2: begin
                                   settextstyle(6, horizDir, 3);
                                   outtextXY(45, 45, 'Witing time (2)');
                                       SetColor(4);
                                       setfillstyle(solidfill, 4);
                                       seek(input, 0);
                                       read(input, counts);
                                       read(input, counts);
                                       read(input, counts);
                                       Moveto(45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                                       for i:= 1 to 20 do begin
                                         read(input, counts);
                                         read(input, counts);
                                         read(input, counts);
                                         lineto(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74));
                                         fillEllipse(i * 28 + 45, 440 - round(counts.tog/(counts.kolobr + 1) * 19.74), 2, 2);
                                       end;
                                     end;
                                  end;
                           end;
                      until (bt = #9);
                    end;
              2: begin
                  SetColor(15);
                  settextstyle(6, horizDir, 3);
                  outtextXY(45, 45, 'Requests in buff');
                  settextstyle(2, horizDir, 5);
                  outtextXY(400, 45, 'Press <- or -> to choose');
                  {P all}
                  axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 2);
                  SetColor(15);
                  setfillstyle(solidfill, 15);
                  seek(input, 0);

                  read(input, counts);
                  kolobr:= counts.kolobr;
                  Moveto(45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                  read(input, counts);
                  read(input, counts);
                  for i:= 1 to 20 do begin
                    read(input, counts);
                    kolobr:= counts.kolobr;
                    lineto(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                    fillEllipse(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97), 2, 2);
                    read(input, counts);
                    read(input, counts);
                  end;
                  repeat
                     bt:= readkey;
                     if bt = #77 then begin
                       res:= res + 1;
                     end;

                     if bt = #75 then begin
                       res:= res - 1;
                     end;

                     if res > 2 then begin
                       res:= 0;
                     end;
                     if res < 0 then begin
                       res:= 2;
                     end;

                     if (bt = #77) or (bt = #75) then begin

                       SetColor(15);
                       settextstyle(6, horizDir, 3);
                       outtextXY(45, 45, 'Requests in buff (all)');
                       ClearViewPort;
                       settextstyle(2, horizDir, 5);
                       outtextXY(400, 45, 'Press <- or -> to choose');

                       axe.coordinates(45, 440, lambdaO, kmin, counts, dynamORconst, 2, 2);
                       case res of
                           0: begin
                                 {P all}
                                 settextstyle(6, horizDir, 3);
                                 outtextXY(45, 45, 'Requests in buff (all)');
                                 SetColor(15);
                                 setfillstyle(solidfill, 15);
                                 seek(input, 0);

                                 read(input, counts);
                                 kolobr:= counts.kolobr;
                                 Moveto(45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                                 read(input, counts);
                                 read(input, counts);
                                 for i:= 1 to 20 do begin
                                   read(input, counts);
                                   kolobr:= counts.kolobr;
                                   lineto(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                                   fillEllipse(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97), 2, 2);
                                   read(input, counts);
                                   read(input, counts);
                                 end;
                              end;
                           1: begin
                                 {p1}
                                 settextstyle(6, horizDir, 3);
                                 outtextXY(45, 45, 'Requests in buff (1)');
                                 SetColor(2);
                                 setfillstyle(solidfill, 2);
                                 seek(input, 0);
                                 read(input, counts);
                                 kolobr:= counts.kolobr;
                                 read(input, counts);
                                 Moveto(45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                                 read(input, counts);
                                 for i:= 1 to 20 do begin
                                   read(input, counts);
                                   kolobr:= counts.kolobr;
                                   read(input, counts);
                                   lineto(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                                   fillEllipse(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97), 2, 2);
                                   read(input, counts);
                                 end;
                               end;
                                 {p2}
                           2: begin
                               settextstyle(6, horizDir, 3);
                               outtextXY(45, 45, 'Requests in buff (2)');
                                   SetColor(4);
                                   setfillstyle(solidfill, 4);
                                   seek(input, 0);
                                   read(input, counts);
                                   kolobr:= counts.kolobr;
                                   read(input, counts);
                                   read(input, counts);
                                   Moveto(45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                                   for i:= 1 to 20 do begin
                                     read(input, counts);
                                     kolobr:= counts.kolobr;
                                     read(input, counts);
                                     read(input, counts);
                                     lineto(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97));
                                     fillEllipse(i * 28 + 45, 440 - round(counts.request/(kolobr + 1) * 66.97), 2, 2);
                                   end;
                                 end;
                              end;
                       end;
                    until (bt = #9);
                  end;
            end;
        end;

        until (tab = #8);

        close(input);

    end;

  procedure windows.main(flag, flag2:INTEGER; var mode1, kolsum, zeroing, dynamORconst:INTEGER; var lambdao:REAL;
            var lambdaofsourse:lambdaofS);

    var simulating:alg;
        alig:integer;

    begin
      case flag of
        0: begin
            simulating.main(lambdao, kolsum, dynamORconst, zeroing, flag2, mode1, lambdaofsourse);
           end;

        1: begin
            case flag2 of
              0: table(dynamORconst, lambdao);
              1: plot(kolsum, dynamORconst, lambdaO);

            end;
           end;

        2: begin
            case flag2 of
              0: mode(mode1);
              1: begin
                  values(zeroing, dynamORconst, kolsum, lambdao);
                  if zeroing = 0 then begin
                    if kolsum > 1500 then begin
                      kolsum:= 1500;
                    end;
                  end;
                  if zeroing = 1 then begin
                    if kolsum > 32000 then begin
                      kolsum:= 32000;
                    end;
                  end;
                 end;
              2: meta(kolsum);
            end;
           end;

      end;
    end;

  constructor windows.init;
    begin
    end;
end.
