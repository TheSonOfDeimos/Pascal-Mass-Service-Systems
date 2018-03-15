UNIT GUI_obj;

Interface

  USES
    graph, types, crt, tpko_obj, boss_obj, wind_obj;

  TYPE
    GUI = object
      constructor init;
      procedure BottomnMain(ButN, alig, flag:integer; nameB:STRING);
      procedure BottomnShift(ButN, alig, flag:integer; nameB:STRING);
      procedure PointingDot(ButN, alig, stpointX, stpointY:INTEGER; var flag:integer; j:STRING);
      procedure menu(var zeroing, dynamORconst, mode1, kolsum:INTEGER; var lambdao:REAL);

    end;

implementation
procedure GUI.BottomnMAin(ButN, alig, flag:integer; nameB:STRING);
    begin

      {main bottomn}
      SetColor(8);

      Rectangle	(GetMaxX div 4, 100  + ALIG , GetMaxX div 4 * 3, 155 + alig);
      SetFillStyle(SolidFill, 8);
      FloodFill(GetMaxX div 4 + 1, 101 + alig, 8);

      SetColor(0);
      Rectangle	(GetMaxX div 4 + 5, 105 + alig, (GetMaxX div 4) * 3 - 5, 150 + alig);
      SetFillStyle(SolidFill, 7);
      FloodFill(GetMaxX div 4 + 10 + 1, 111 + alig, 0);

      SetColor(8);
      settextstyle(0, horizDir, 3);
      outtextxy(GetMaxX div 3  - 30, (150 + alig) - 31  , nameB);
    end;

procedure GUI.BottomnShift(ButN, alig, flag:integer; nameB:STRING);
      var alignment, i:INTEGER;
          sim: ARRAY [0 .. 3] OF STRING ;
          res: ARRAY [0 .. 1] OF STRING ;
          seti:ARRAY [0 .. 2] OF STRING ;
      begin
        sim[0]:= ' REJECTION';
        sim[1]:= ' WAITING T.';
        sim[2]:= 'REQ.IN BUF.';
        sim[3]:= '    ALL';
        res[0]:= '   TABLE';
        res[1]:= '   PLOT';
        seti[0]:= '   MODE';
        seti[1]:= '  VALUES';
        seti[2]:= '   META';
        {secondary bottomn --> main bottomn}
         alignment:= alig;
        if flag > -1 then begin
             for i:= 1 to ButN do begin
              SetColor(8);
              Rectangle	(GetMaxX div 4 + 15, 160 + alignment , GetMaxX div 4 * 3 - 15, 205 + alignment);
              SetFillStyle(SolidFill, 8);
              FloodFill(GetMaxX div 4 + 15 + 1, 160 + alignment + 1, 8);


              SetColor(7);
              settextstyle(0, horizDir, 3);
              case flag of
                0: begin
                    outtextxy(GetMaxX div 3  - 20, 160 + alignment + 12  , sim[i - 1]);
                   end;
                1: begin
                    outtextxy(GetMaxX div 3  - 20, 160 + alignment + 12  , res[i - 1]);
                   end;
                2: begin
                    outtextxy(GetMaxX div 3  - 20, 160 + alignment + 12  , seti[i - 1]);
                   end;
              end;

              alignment:= alignment + 50;{+ diff}

              delay(50);

             end;
        end;
      end;

procedure GUI.PointingDot(ButN, alig, stpointX, stpointY:integer; var flag:INTEGER; j:STRING);
  begin


      if j = #80 then begin
        setFillStyle(SolidFill, 0);
        SetColor(0);
        fillEllipse(stpointX ,stpointY + alig * flag, 6, 6);
         flag:= flag + 1;
      end;

      if j = #72 then begin
        setFillStyle(SolidFill, 0);
        SetColor(0);
        fillEllipse(stpointX ,stpointY + alig * flag, 6, 6);
          flag:= flag - 1;
      end;

      if flag > ButN - 1 then
        flag:= flag - ButN;
      if flag < 0 then
        flag:= flag + ButN;

      if flag >= 0 then begin
        SetFillStyle(SolidFill, 8);
        setcolor(8);
        fillEllipse(stpointX ,stpointY + alig * flag, 6, 6);
      end;
    end;

procedure GUI.Menu(var zeroing, dynamORconst, mode1, kolsum:INTEGER; var lambdao:REAL);
  label goback, goback2, goback3, goback4;
  var
    alig, flag, flag2, tick:integer;
    j, bt:string;
    modes:windows;


  begin
    flag:= -1;
    flag2:= -1;
    alig:= 60;
    bt:= #4;
    {follow point}
    goback:{111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111}
    ClearViewPort;
    BottomnMAin(3, alig * 0, flag, '  SIMULATE');
    BottomnMAin(3, alig * 1, flag, '   RESULT');
    BottomnMAin(3, alig * 2, flag, '  SETTINGS');
    if bt = #8 then
      PointingDot(3, alig, (GetMAxX div 4) - 15, 125, flag, j);
        repeat
          j:=readkey;
          if j<>#27 then begin
            PointingDot(3, alig, (GetMaxX div 4) - 15, 125, flag, j);

            if j = #13 then begin
              ClearViewPort;
              case flag of
                0:begin
                    goback4:
                    BottomnMAin(3,  flag * alig, flag, '  SIMULATE');
                    BottomnMAin(3,  (flag * alig) + (5 * 50) + 10, flag, '   RESULT');
                    BottomnMAin(3,  (flag * alig) +(5 * 50) + 70  , flag, '  SETTINGS');
                    delay(100);
                    BottomnShift(4, flag * alig, flag, 'Simulate');
                    flag2:= -1;
                    repeat
                      bt:= readkey;
                      if bt <> #8 then begin
                        PointingDot(4, 50, (GetMaxX div 4) - 10, (125 + 60 * flag) + 55, flag2, bt);
                        if bt = #13 then begin
                          ClearViewPort;
                          modes.main(flag, flag2, mode1, kolsum, zeroing, dynamORconst, lambdao);
                          goto goback4{222222222222222222222222222222222222222}
                          {give someone flag, flag2}
                        end;
                      end;

                    until (bt = #8);
                    goto goback;

                  end;
                1:begin
                    goback3:
                    BottomnMAin(3,  0 * alig, flag, '  SIMULATE');
                    BottomnMAin(2,  (1 * alig), flag, '   RESULT');
                    BottomnMAin(3,  (flag * alig) +(3 * 50) + 10  , flag, '  SETTINGS');
                    delay(100);
                    BottomnShift(2, flag * alig, flag, 'Simulate');
                    flag2:= -1;
                    repeat
                      bt:= readkey;
                      if bt <> #8 then begin
                        PointingDot(2, 50, (GetMaxX div 4) - 10, (125 + 60 * flag) + 55, flag2, bt);
                        if bt = #13 then begin
                          ClearViewPort;
                          modes.main(flag, flag2,  mode1, kolsum, zeroing, dynamORconst, lambdao);
                          goto goback3{222222222222222222222222222222222222222}
                        end;
                      end;
                    until (bt = #8);
                    goto goback;

                  end;
                2:begin

                    goback2:{222222222222222222222222222222222222222}
                    ClearViewPort;
                    BottomnMAin(3,  0 * alig, flag, '  SIMULATE');
                    BottomnMAin(3,  (1 *  alig) , flag, '   RESULT');
                    BottomnMAin(3,  (2 * alig) , flag, '  SETTINGS');
                    delay(100);
                    BottomnShift(3, flag * alig, flag, 'Simulate');
                    flag2:= -1;
                    repeat
                      bt:= readkey;
                      if bt <> #8 then begin
                        PointingDot(3, 50, (GetMaxX div 4) - 10, (125 + 60 * flag) + 55, flag2, bt);
                        if bt = #13 then begin
                          ClearViewPort;
                          modes.main(flag, flag2,  mode1, kolsum, zeroing, dynamORconst, lambdao);
                          goto goback2{222222222222222222222222222222222222222}
                          {give someone flag, flag2}
                        end;
                      end;
                    until (bt = #8);
                    goto goback;{1111111111111111111111111111111111111111111111111111111111111111111111}

                  end;
              end;
            end;

           end;
        until j=#27;
  end;


  constructor GUI.init;
    begin
    end;

end.
