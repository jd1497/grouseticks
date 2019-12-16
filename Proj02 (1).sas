proc import datafile="C:/Users/jiali/Downloads/grouseticks.csv"
 out=gt dbms=dlm;
 delimiter=',';
 getnames=yes;
run;

proc print data=gt /*(obs=15)*/;
run;

proc glm data=gt plots=diagnostics (unpack);
class INDEX BROOD HEIGHTGROUP YEAR LOCATION;
model TICKS=HEIGHT YEAR brood location index(brood)/solution E;
random brood location index(brood);
run;

proc glm data=gt plots=diagnostics (unpack);
class INDEX BROOD HEIGHTGROUP YEAR LOCATION;
model TICKS=HEIGHTGROUP YEAR brood location index(brood)/solution E;
random brood location index(brood);
run;

proc mixed data=gt cl covtest;
class INDEX BROOD HEIGHTGROUP YEAR LOCATION;
model TICKS=HEIGHTGROUP YEAR/solution E;
random brood location index(brood);
run;

proc mixed data=gt;
class INDEX BROOD HEIGHTGROUP YEAR LOCATION;
model TICKS=HEIGHTGROUP YEAR/ddfm=satterth solution E;
random brood location index(brood);
run;

proc mixed data=gt;
class INDEX BROOD HEIGHTGROUP YEAR LOCATION;
model TICKS=HEIGHTGROUP YEAR/ddfm=kr solution E;
random brood location index(brood) location*index(brood)/solution;
run;
