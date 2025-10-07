cat > lexer.l << 'EOF'
%{
#include <stdio.h>
static void tk(const char* t){ printf("<%s,%s>\n", t, yytext); }
%}

%option noyywrap
%option yylineno
%option caseless

%x COMMENT
%x AFTEREND

WS      [ \t\r\n]+
ID      [A-Z][A-Z-]*
NUM     (0|[1-9][0-9]*)
DQS     \"([^\"\\]|\\.)*\"
SQS     \'([^\'\\]|\\.)*\'

%%

"/:"                { BEGIN(COMMENT); }
<COMMENT>":/"       { BEGIN(INITIAL); }
<COMMENT>.|\n       { /* ignore */ }

<AFTEREND>.|\n      { /* ignore all after END */ }

{WS}                { /* skip */ }

"INT"               { tk("KW_INT"); }
"FLOAT"             { tk("KW_FLOAT"); }
"CHAR"              { tk("KW_CHAR"); }
"FUNCTION"          { tk("KW_FUNCTION"); }
"MAIN"              { tk("KW_MAIN"); }
"BEGIN"             { tk("KW_BEGIN"); }
"WHILE"             { tk("KW_WHILE"); }

"END"               { tk("KW_END"); BEGIN(AFTEREND); }

{NUM}               { tk("NUM_INT"); }
{DQS}               { tk("STRING_DQ"); }
{SQS}               { tk("STRING_SQ"); }
{ID}                { tk("ID"); }

"=="                { tk("OP_EQ"); }
"!="                { tk("OP_NE"); }
"->"                { tk("OP_ARROW"); }
"<"                 { tk("OP_LT"); }
">"                 { tk("OP_GT"); }
"+"                 { tk("OP_ADD"); }
"-"                 { tk("OP_SUB"); }
"*"                 { tk("OP_MUL"); }
"/"                 { tk("OP_DIV"); }
"="                 { tk("OP_ASSIGN"); }
"?"                 { tk("OP_QMARK"); }

";"                 { tk("SEMI"); }
","                 { tk("COMMA"); }
":"                 { tk("COLON"); }
"("                 { tk("LPAREN"); }
")"                 { tk("RPAREN"); }
"{"                 { tk("LBRACE"); }
"}"                 { tk("RBRACE"); }

.                   { fprintf(stderr,"[line %d] invalid_char: %s\n", yylineno, yytext); }

%%

/* int main(void){ yylex(); return 0; } */
