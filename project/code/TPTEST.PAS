USES

crt, graph, tpko_obj, types;

VAR
  x,i, y, g, h:INTEGER;
  j, c, s:string;
  gr:graphik;
  mode, dynamorconst, flag,  kmin:integer;
  lambdao:real;

  counts:count;
  zeroing, mode1, kolsum:INTEGER;

BEGIN
  g:= detect;
  initgraph(g, h, '');

  dynamORconst:= 0;
  counts.kol:= 1500;
  mode:= 2;
  flag:= ;
  lambdao:= 1;
  kmin:= 1500;
  x:= 45;
  y:= 440;

  gr.coordinates(x, y, lambdaO, kmin, counts, dynamORconst, mode, flag);
  j:= readkey;
  closegraph;

END.
