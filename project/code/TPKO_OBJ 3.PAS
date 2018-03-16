unit tpko_obj;

interface

uses
  crt, graph, types;

TYPE
  graphik = object
    constructor init;
    procedure coordinates(x,y:integer; func:string);
    procedure DrawPoint(counts, counts1, counts2:count; kolsum:INTEGER; req_in_buf:LONGINT; flag2:INTEGER);
    procedure SimulationInfo(tog:real; indbuf, ob:buff; kol, kotk, kolobr, req_in_buf , graphTYPE:integer);
  end;

implementation

  procedure graphik.DrawPoint(counts, counts1, counts2:count; kolsum:INTEGER; req_in_buf:LONGINT; flag2:INTEGER);
    begin
      case flag2 of
          0: putpixel(round(counts.kol/(kolsum/560)) + 45, 440 - (round((counts.kotk/(counts.kol + 1))* 200)) , 15);
          1: putpixel(round(counts.kol/(kolsum/560)) + 45, 440 - (round((counts.tog/(counts.kolobr + 1)) * 12)) , 15);
          2: putpixel(round(counts.kol/(kolsum/560)) + 45, 440 - (round((req_in_buf/(counts.kol + 1)))) , 15);
      end;

    end;

  procedure graphik.coordinates(x,y:INTEGER; func:STRING);
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
      outtextxy(270  - x, y + 15  , 'Lambda of Servise');
      settextstyle(6, vertDir,1);
      outtextxy(x - 45, y - 140 , 'Probability');
    end;

  procedure graphik.SimulationInfo(tog:real; indbuf, ob:buff; kol, kotk, kolobr, req_in_buf ,graphTYPE:integer);
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
        str(req_in_buf/(kol div 100):5:2, wordn);
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
