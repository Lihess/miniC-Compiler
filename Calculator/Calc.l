%{
    #include "Calc.tab.h"
    #include <math.h>
    extern double vbltable[26]; // 저장할 심볼테이블
%}
%%
([0-9]+|([0-9]*\.[0-9]+)?) {yylval.val = atof(yytext); return NUMBER;} // 정수와 실수 모두 지원
[ \t]; // 공백 무시
[a-z]+ {yylval.idno = yytext[0] - 'a'; return NAME;} // 변수명은 알파벳만 허용
"$" return 0; // 종료 기호
\n|. return yytext[0]; 
%%
