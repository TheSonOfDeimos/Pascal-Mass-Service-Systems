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
    procedure SimulationInfo(counts, counts1, counts2:count; lambdaO:REAL; flag2:INTEGER);
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
          begin
            settextstyle(smallfont, horizDir, 4);
            for i:= 0 to 9 do begin
              str(10 * (i + 1), num);
              outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5 , num);
            end;
            settextstyle(6, vertDir,1);
            outtextxy(x - 45, y - 145 , 'Probability');
          end;
        1: {Waiting time}
          begin
            settextstyle(smallfont, horizDir, 4);
            for i:= 0 to 9 do begin
              str((i + 1), num);
              outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5, num);
            end;
            settextstyle(6, vertDir,1);
            outtextxy(x - 45, y - 163 , 'Wiaiting time');
          end;
        2: {request}
          begin
            settextstyle(smallfont, horizDir, 4);
            for i:= 0 to 9 do begin
              str(0.4 * (i + 1 ):1:1, num);
              outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5, num);
            end;
            settextstyle(6, vertDir,1);
            outtextxy(x - 45, y - 175 , 'Requests in buff');
          end;
        3: {all}
          begin
            settextstyle(smallfont, horizDir, 4);
            for i:= 0 to 9 do begin
              str(10 * (i + 1 ), num);
              outtextxy(x - 20 , (y  - 20 * (i + 1)) - 5, num);
            end;
          end;
      end;

      {OX param}
      incr:= 0;
      case mode of
        0: {steping}
          begin
            settextstyle(smallfont, horizDir, 4);
            for i:= 0 to 19 do begin
              str(((kmin / 20) * (i + 1) ):4:0, num);
              outtextxy((28 * (i + 1)) + 33 , y + 3, num);
            end;
            settextstyle(6, HorizDir,1);
            str(lambdaO:1:1, num);
            outtextxy(25, 30, 'Lambda: ' + num);
            outtextxy(320  - x, y + 15  , 'Requests');
          end;
        1:; {ofline}
        2: {all}
          begin
            settextstyle(smallfont, horizDir, 4);
            for i:= 0 to 19 do begin
              if dynamORconst = 1 then begin
                str(0.1 * (i + 11):1:1, num);
              end;
              if dynamORconst = 0 then begin
                str(((kmin/10) * (i + 2)):4:0, num);
              end;
              outtextxy((28 * (i + 1)) + 33 , y + 3, num);
            end;
            settextstyle(6, HorizDir,1);
            if dynamORconst = 0 then begin
              str(lambdaO:1:1, num);
              outtextxy(25, 30, 'Lambda: ' + num);
              outtextxy(320  - x, y + 15  , 'Requests');
            end;
            if dynamORconst = 1 then begin
              str(lambdaO:1:1, num);
              outtextxy(270  - x, y + 15  , 'Lambda of Service');
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

  procedure graphik.SimulationInfo(counts, counts1, counts2:count; lambdaO:REAL; flag2:INTEGER);
    var
        wordn, num:STRING;
        alignment:integer;
    begin
        SetColor(0);
        settextstyle(6, HorizDir,1);
        str(lambdaO:1:1, num);
        outtextxy(45, 45, 'Lambda: ' + num);
        alignment:= 20;
        SetColor(15);
        case flag2 of
          0 : outtextxy(25 , 50 + 0 * alignment , 'Rejection probability');
          1 : outtextxy(25 , 50 + 0 * alignment , 'Waiting time');
          2 : outtextxy(25 , 50 + 0 * alignment , 'Number of requests in the buffer');
        end;
        settextstyle(2, HorizDir,4);

        {ALL sourses}
        str(counts.kol:5, wordn);
        wordn:= 'number of requests (all):  ' + wordn;
        outtextxy(25, 60 + 1 * alignment , wordn );

        str(counts.kolobr:5, wordn);
        wordn:= 'number of procesed (all):  ' + wordn;
        outtextxy(25 , 60 + 2 * alignment , wordn);

        str(counts.tog:5:2, wordn);
        wordn:= 'total waiting time (all):  ' + wordn;
        outtextxy(25 , 60 + 3 * alignment , wordn);

        str((counts.tog/counts.kolobr):5:2, wordn);
        wordn:= 'average witing time (all): ' + wordn;
        outtextxy(25 , 60 + 4 * alignment , wordn);

        str((counts.request/counts.kolobr):5:2, wordn);
        wordn:= 'average req in buff (all): ' + wordn;
        outtextxy(25 , 60 + 5 * alignment , wordn);

        str(((counts.kotk/counts.kol) * 100):5:2, wordn);
        wordn:= 'rej. probability (all):    ' + wordn + '%';
        outtextxy(25 , 60 + 6 * alignment , wordn);

        {1 sourse}
        str(counts1.kol:5, wordn);
        wordn:= 'number of requests (1):  ' + wordn;
        outtextxy(240, 60 + 1 * alignment , wordn );

        str(counts1.kolobr:5, wordn);
        wordn:= 'number of procesed (1):  ' + wordn;
        outtextxy(240 , 60 + 2 * alignment , wordn);

        str(counts1.tog:5:2, wordn);
        wordn:= 'total waiting time (1):  ' + wordn;
        outtextxy(240 , 60 + 3 * alignment , wordn);

        str((counts1.tog/counts1.kolobr):5:2, wordn);
        wordn:= 'average witing time (1): ' + wordn;
        outtextxy(240 , 60 + 4 * alignment , wordn);

        str((counts1.request/counts1.kolobr):5:2, wordn);
        wordn:= 'average req in buff (1): ' + wordn;
        outtextxy(240 , 60 + 5 * alignment , wordn);

        str(((counts1.kotk/counts1.kol) * 100):5:2, wordn);
        wordn:= 'rej. probability (1):    ' + wordn + '%';
        outtextxy(240 , 60 + 6 * alignment , wordn);

        {2 sourse}
        str(counts2.kol:5, wordn);
        wordn:= 'number of requests (2):  ' + wordn;
        outtextxy(430, 60 + 1 * alignment , wordn );

        str(counts2.kolobr:5, wordn);
        wordn:= 'number of procesed (2):  ' + wordn;
        outtextxy(430 , 60 + 2 * alignment , wordn);

        str(counts2.tog:5:2, wordn);
        wordn:= 'total waiting time (2):  ' + wordn;
        outtextxy(430 , 60 + 3 * alignment , wordn);

        str((counts2.tog/(counts2.kolobr + 1)):5:2, wordn);
        wordn:= 'average witing time (2): ' + wordn;
        outtextxy(430 , 60 + 4 * alignment , wordn);

        str((counts2.request/(counts2.kolobr + 1)):5:2, wordn);
        wordn:= 'average req in buff (2): ' + wordn;
        outtextxy(430 , 60 + 5 * alignment , wordn);

        str(((counts2.kotk/counts2.kol) * 100):5:2, wordn);
        wordn:= 'rej. probability (2):    ' + wordn + '%';
        outtextxy(430 , 60 + 6 * alignment , wordn);

   end;

  constructor graphik.init;
              begin
              end;
end.
