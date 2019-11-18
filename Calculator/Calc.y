%{
    #include <stdio.h>
    double reg[25];
%}
%union{ // 사용가능한 기호의 타입 지정
     double val;
     int idno;
}
%token <idno> NAME // 토큰 지정
%token <val> NUMBER // 토큰 지정
%left '+''-' // 좌결합 연산자임을 letf를 통해 알림
%left '*''/' // *, / 의 우선순위가 더 높음을 명시적으로 표현
%nonassoc UMINUS // 단항 마이너스를 위한 임시 토큰이 가장 우선순위가 높음
%type <val> expr 
%%
program: statement '\n'
         | program statement '\n'
         ;
statement : NAME '=' expr {reg[$1] = $3;}
         | expr {printf("= %g\n", $1);}
         ;
expr : expr '+' expr {$$ = $1 + $3;}
         | expr '-' expr {$$ = $1 - $3;}
         | expr '*' expr {$$ = $1 * $3;}
         | expr '/' expr {
             if($3 == 0.0) yyerror("divide by zero"); // 0으로 나누려할때
             else $$ = $1 / $3;
        }
         | '-' expr %prec UMINUS{$$ = -$2;}
         | '(' expr ')' {$$ = $2;}
         | NUMBER
         | NAME {$$ = reg[$1];}
         ;
 %%
 //extern int yydebug;
 //yydebug = 1;
 int main(void){
     return yyparse();
 }
 void yyerror(char* s){
     printf("%s.\n", s);
        exit(1);
 }
