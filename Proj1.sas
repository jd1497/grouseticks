proc import datafile='C:/Users/JiaLi/Downloads/MATH558DesignExp/GP/grouseticks.CSV'
 out=gt dbms=dlm;
 delimiter=',';
 getnames=yes;
run;

proc print data=gt /*(obs=15)*/;
run;

ods graphics on;
proc glm data=gt plot=diagnostics;
class INDEX brood year location;
model Ticks=height year;
random brood index(brood) location;
/*means Technique/HOVTEST=BF /*option on the left can be any of LEVENE(type=abs), BF, BARTLETT WELCH;*/
run;
quit;
ods graphics off;

proc mixed cl covtest data=gt;
class INDEX brood year location;
model Ticks=height year height*year;
random brood(year) index(brood) location;
/*means Technique/HOVTEST=BF /*option on the left can be any of LEVENE(type=abs), BF, BARTLETT WELCH;*/
run;
quit;
proc mixed cl covtest data=gt;
class INDEX brood year location heightgroup;
model Ticks=heightgroup year heightgroup*year;
random brood index(brood) location/solution;
/*means Technique/HOVTEST=BF /*option on the left can be any of LEVENE(type=abs), BF, BARTLETT WELCH;*/
run;
quit;

proc glm data=gt plot=diagnostics;
class INDEX brood year location heightgroup;
model Ticks=heightgroup year heightgroup*year;
random brood index(brood) location;
run;
quit;

proc mixed cl covtest data=gt;
class INDEX brood year location;
model Ticks=height year;
random brood(year) index(brood) location;
/*means Technique/HOVTEST=BF /*option on the left can be any of LEVENE(type=abs), BF, BARTLETT WELCH;*/
run;
quit;


proc mixed cl covtest data=gt;
class INDEX brood year location;
model Ticks=height year;
random brood index(brood) location;
/*means Technique/HOVTEST=BF /*option on the left can be any of LEVENE(type=abs), BF, BARTLETT WELCH;*/
run;
quit;


proc mixed cl covtest data=hw4_01;
class Technique;
model Time=Technique/ddfm=kr;
repeated/group=Technique;
lsmeans Technique/diff cl;
run;
quit;
