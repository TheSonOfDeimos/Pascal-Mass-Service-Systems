unit tpko_obj;

interface

uses
  crt, graph, types;

TYPE
  graphik = object
    constructor init;
    procedure coordinates1(x,y:integer; func:string);
    procedure coordinates(x , y: INTEGER; lambdao:real; kmin:INTEGER; counts:count; dynamORconst, mode, flag2 :INTEGER);
    procedure DrawPoint(counts:count; kolsum:INTEGER;  flag2:INTEGER);
    procedure DrawPointZERO(counts:count; ORDENATE, mode, flag2:INTEGER);
    procedure SimulationInfo(tog:real; indbuf, ob:buff; kol, kotk, kolobr, graphTYPE:integer);
  end;

implementation
  procedure graphik.DrawPointZERO(counts:count; ORDENATE, mode, flag2:INTEGER);
    begin
      case mode of
        0:
          case flag2 of
          0:
            putpixel(ORDENATE + 45, 440 - (round((counts.kotk / (counts.kol + 1)) * 200)) , 15);
          1:
            putpixel(ORDENATE + 45, 440 - (round((counts.tog / (counts.kolobr + 1)) * 12)) , 15);
          2:
            putpixel(ORDENATE + 45, 440 - (round((counts.request/(counts.kolobr + 1))* 50)) , 15);
          end;
        1:;
        2:
          case flag2 of
            0:
              putpixel(ORDENATE + 45, 440 - (round((counts.kotk / (counts.kol + 1)) * 200)) , 15);
            1:
              putpixel(ORDENATE + 45, 440 - (round((counts.tog / (counts.kolobr + 1)) * 12)) , 15);
            2:
              putpixel(ORDENATE + 45, 440 - (round((counts.request/(counts.kolobr + 1))* 50)) , 15);
          end;
      end;
    end;

  procedure graphik.DrawPoint(counts:count; kolsum:INTEGER; flag2:INTEGER);
    begin
      case flag2 of
          0: putpixel(round(counts.kol/(kolsum/560)) + 45, 440 - (round((counts.kotk/(counts.kol + 1))* 200)) , 15);
          1: putpixel(round(counts.kol/(kolsum/560)) + 45, 440 - (round((counts.tog/(counts.kolobr + 1)) * 12)) , 15);
          2: putpixel(round(counts.kol/(kolsum/560)) + 45, 440 - (round((counts.request/(counts.kolobr + 1)) * 50)) , 15);
      end;

    end;

  procedure graphik.coordinates(x , y: INTEGER; lambdao:real; kmin:INTEGER; counts:count; dynamORconst, mode, flag2 :INTEGER);
    var
      incr, i:INTEGER;
      num:string;
    begin
      settextstyle(smallfont, horizDir, 4);
      SetColor(15);
      {coordinates}
      Line(x, y, x + 560, y);
      Line(x, y, x , y - 210);
      incr:= 0;
      for i:= 0 to 9 do begin
        incr:= incr + 20;
        line(x + 1, y - incr, x - 1, y - incr);
      end;
      incr:= 0;
      for i:= 0 to 19 do begin
        incr:= incr + 28;
        line(incr + x, y + 1, incr + x, y - 1);
      end;

      incr:= 0;
      {OY param}
      case flag2 of
        0: {rejection}
          for i:= 0 to 9 do begin
            str(10 * (i + 1), num);
            outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5 , num);
          end;
        1: {Waiting time}
          for i:= 0 to 9 do begin
            str((i + 1), num);
            outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5, num);
          end;
        2: {request}
          for i:= 0 to 9 do begin
            str(0.4 * (i + 1 ):1:1, num);
            outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5, num);
          end;
        3: {all}
          for i:= 0 to 9 do begin
            str(10 * (i + 1 ), num);
            outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5, num);
          end;
      end;

      {OX param}
      incr:= 0;
      case mode of
        0: {steping}
          begin
            str(lambdaO:1:1, num);
            outtextxy(45, 45, 'Lambda: ' + num);
            for i:= 0 to 19 do begin
              str(((kmin / 20) * (i + 1) ):4:0, num);
              outtextxy((28 * (i + 1)) + 33 , y + 3, num);
            end;
          end;
        1:; {ofline}
        2: {all}
          begin
            if dynamORconst = 0 then begin
              str(lambdaO:1:1, num);
              outtextxy(45, 45, 'Lambda: ' + num);
            end;
            for i:= 0 to 19 do begin
              if dynamORconst = 1 then begin
                str(0.1 * (i + 11):1:1, num);
              end;
              if dynamORconst = 0 then begin
                str(((kmin/10) * (i + 1)):4:0, num);
              end;
              outtextxy((28 * (i + 1)) + 33 , y + 3, num);
            end;
          end;

      end;
    end;

  procedure graphik.coordinates1(x,y:INTEGER; func:STRING);
   var incr, i: integer;
       num: string;
       f:real;
   begin

      {style}
      settextstyle(smallfont, horizDir, 4);
      SetColor(15);

      {coordinates}
      Line(x, y, x + 560, y);
      Line(x, y, x , y - 210);

      {nums on axes}
      f:= 1;
      incr:= 0;
      for i:= 0 to 19 do begin
        f:= f + 0.1;

        incr:= incr + 28;
        line(incr + x, y + 1, incr + x, y - 1);

        if func  = 'numUP' then
          str(f:1:1, num);
        if func = 'numDOWN' then
          str(4 - f:1:1, num);
        outtextxy(incr + 33 , y + 3, num);
      end;

      incr:= 0;
      for i:= 0 to 9 do begin
        incr:= incr + 20;
        line(x + 1, y - incr, x - 1, y - incr);

        str(10 * (i + 1), num);
        outtextxy(x - 20 , y  - incr - 5 , num);
      end;

      {names of axes}
      settextstyle(6, HorizDir,1);
      outtextxy(270  - x, y + 15  , 'Lambda of Serviсe');
      settextstyle(6, vertDir,1);
      outtextxy(x - 45, y - 140 , 'Probability');
    end;

  procedure graphik.SimulationInfo(tog:real; indbuf, ob:buff; kol, kotk, kolobr, graphTYPE:integer);
    var
        wordn:STRING;
        alignment:integer;
    begin

        settextstyle(6, HorizDir,1);
        alignment:= 20;
        case graphTYPE of
          0 : outtextxy(10 , 50 + 0 * alignment , 'Rejection probability');
          1 : outtextxy(10 , 50 + 0 * alignment , 'Waiting time');
          2 : outtextxy(10 , 50 + 0 * alignment , 'Number of requests in the buffer');
        end;
        settextstyle(2, HorizDir,5);

        {1 coloumn}
        str(kol:5, wordn);
        wordn:= 'number of requests: ' + wordn;
        outtextxy(10 , 60 + 1 * alignment , wordn );

        str(indbuf^.buft - ob^.buft:5:2, wordn);
        wordn:= 'waiting time:       ' + wordn;
        outtextxy(10 , 60 + 2 * alignment , wordn);

        str(kotk:4, wordn);
        wordn:= 'number of rejection: ' + wordn;
        outtextxy(10 , 60 + 3 * alignment , wordn );

        str(kolobr:4, wordn);
        wordn:= 'number of procesed: ' + wordn;
        outtextxy(10 , 60 + 4 * alignment , wordn);

        str(indbuf^.bufp:2, wordn);
        wordn:= 'requests in buffer: ' + wordn;
        outtextxy(10 , 60 + 5 * alignment , wordn );


        {2 coloumn}
        str(tog:10:2, wordn);
        wordn:= 'total waiting time: ' + wordn;
        outtextxy(400 , 60 + 1 * alignment , wordn);

        str(tog/kolobr:5:2, wordn);
        wordn:= 'average witing time: ' + wordn;
        outtextxy(400 , 60 + 2 * alignment , wordn);
        {
        str(counts.request/(kol div 100):5:2, wordn);
        wordn:= 'average req in buff: ' + wordn;
        outtextxy(400 , 60 + 3 * alignment , wordn);

        str((kotk/kol) * 100:7:2, wordn);
        wordn:= 'rej. probability:    ' + wordn + '%';
        outtextxy(400 , 60 + 4 * alignment , wordn);
      }

   end;

  constructor graphik.init;
              begin
              end;
end.
