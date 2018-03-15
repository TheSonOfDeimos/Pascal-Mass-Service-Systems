uses boss_obj, types, graph, crt, tpko_obj, alg_obj;




var

   elem1, elem2		  : call;
   kol, kolprev, i, kolobr, kotk, save	, req_in_buf  : integer;
   tosv, tog		  : real;
   lambdaO,	r1, r2  : real;
   indbuf, tail, ob, head : buff;
   bos			  : boss;
   j:string;

   {graph}
   gd, gm, x, y, kolsum:INTEGER;
   gr: graphik;

   simulating:alg;

begin

     gd:= detect;
    initgraph(gd, gm, '');

    simulating.main(lambdao, kolsum, 1);
   closegraph;
   



end.
