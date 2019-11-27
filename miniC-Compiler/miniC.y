%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTICT
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token BOOL COMPLEX IMAGINARY
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit
%%

primary_expression : IDENTIFIER 
                    | CONSTANT 
                    | STRING_LITERAL 
                    | '(' expression ')';

postfix_expression : primary_expression
                    | postfix_expression '[' expression ']'
                    | postfix_expression '(' ')'
                    | postfix_expression '(' argument_expression_list ')'
                    | postfix_expression PTR_OP IDENTIFIER
                    | postfix_expression INC_OP
                    | postfix_expression DEC_OP
                    | '(' type_name ')' '{' initializer_list '}'
                    | '(' type_name ')' '{' initializer_list ',' '}';

argument_expression_list : assignment_expression
                        | argument_expression_list ',' assignment_expression;

unary_expression : postfix_expression
                | INC_OP unary_expression
                | DEC_OP unary_expression
                | unary_operator cast_expression
                | SIZEOF unary_expression
                | SIZEOF '(' type_name ')';

unary_operator : '&' | '=' | '+' | '-' | '~' | '!';

cast_expression : unary_expression
                | '(' type_name ')' cast_expression;

multiplicative_expression : cast_expression
                            | multiplicative_expression '*' cast_expression
                            | multiplicative_expression '/' cast_expression
                            | multiplicative_expression '%' cast_expression;

additive_expression : multiplicative_expression
                    | additive_expression '+' multiplicative_expression
                    | additive_expression '-' multiplicative_expression;

shift_expression : additive_expression 
                | shift_expression LEFT_OP additive_expression
                | shift_expression RIGHT_OP additive_expression;

relational_expression : shift_expression
                        | relational_expression '<' shift_expression
                        | relational_expression '>' shift_expression
                        | relational_expression LE_OP shift_expression
                        | relational_expression GE_OP shift_expression;

equality_expression : relational_expression
                    | equality_expression EQ_OP relational_expression
                    | equality_expression NE_OP relational_expression;

and_expression : equality_expression
                | and_expression '&' equality_expression;

exclusive_or_expression : and_expression
                        | exclusive_or_expression '^' and_expression;

inclusive_or_expression : exclusive_or_expression
                        | inclusive_or_expression '|' exclusive_or_expression;

logical_and_expression : inclusive_or_expression
                        | logical_and_expression AND_OP inclusive_or_expression;

logical_or_expression : logical_and_expression
                    : logical_or_expression OR_OP logical_and_expression;

conditional_expression : logical_or_expression
                        | logical_or_expression '?' expression ':' conditional_expression;

assignment_expression : conditional_expression
                        | unary_expression assignment_operator assignment_expression;

assignment_operator : '='
                    | MUL_ASSIGN
                    | DIV_ASSIGN
                    | MOD_ASSIGN
                    | ADD_ASSIGN
                    | SUB_ASSIGN
                    | LEFT_ASSIGN
                    | RIGHT_ASSIGN
                    | AND_ASSIGN
                    | XOR_ASSIGN
                    | OR_ASSIGN;

expression : assignment_expression
            | expression ',' assignment_expression;

costant_expression: conditional_expression;

declaration : declaration_specifiers ';'
            | declaration_xpecifiers init_declarator_list ';';

declaration_specifiers : storage_class_specifier
                        | storage_class-specifier declaration_specifiers
                        | type_specifier
                        | type_specifier declaration_specifiers
                        | type_qualifier
                        | type_qualifier declaration_specifiers
                        | funtion_specifier
                        | funtion_specifier declaration_specifiers;

init_declarator_list : init_declarator
                        | init_declartor_list ',' init_declarator;

init_declarator : declarator
                | declarator '=' initializer;

storage_class_specifier : TYPEDEF 
                        | EXTERN
                        | STATIC
                        | AUTO
                        | REGISTER;

type_specifier : VOID
                | CHAR
                | SHORT
                | INT
                | LONG
                | FLOAT
                | DOUBLE
                | SIGNED
                | UNSIGNED
                | BOOL
                | COMPLEX
                | IMAGINARY
                | struct_or_union_specifier
                | enum_specifier
                | TYPE_NAME;


