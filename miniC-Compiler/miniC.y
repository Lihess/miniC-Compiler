%token IDENTIFIER I_CONSTANT F_CONSTANT STRING_LITERAL FUNC_NAME SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN
%token TYPE_NAME ENUMERATON_CONSTANT

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE
%token CONST RESTICT VOLATILE
%token BOOL CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE VOID
%token COMPLEX IMAGINARY
%token STRUCT UNION ENUM ELLIPSIS
 
%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN
%token ALIGNAS ALIGNOF ATOMIC GENERIC NORETURN STATIC_ASSERT THREAD_LOCAL
 
%start translation_unit

%%

primary_expression : IDENTIFIER
                     | constant
                     | string
                     | '(' expression ')'
                     | generic_selection;

constant : I_CONSTANT 
            | F_CONSTANT
            | EUMERATION_CONSTANT;

enumeration_constan : IDENTIFIER;

string : STRING_LITERAL
        | FUNC_NAME;

generic_selsction : GENERIC '(' assignment_expression ',' generiv_assoc_list

generic_assoc_list : generic_association
                    | generic_assoc_list ',' generic_association;

generic_association : type_name ':' assignment_expression
                    | DEFAULT ':' assignment_expression;
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
                | SIZEOF '(' type_name ')'
                | ALIGNOF '(' type_name ')';

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
                        | funtion_specifier declaration_specifiers 
                        | alignment_specifier
                        | alignment_specifier declaration_specifiers;

init_declarator_list : init_declarator
                        | init_declartor_list ',' init_declarator;

init_declarator : declarator
                | declarator '=' initializer;

storage_class_specifier : TYPEDEF 
                        | EXTERN
                        | STATIC
                        | THREAS_LOCAL
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
                | atomic_type_specifier
                | struct_or_union_specifier
                | enum_specifier
                | TYPE_NAME;


