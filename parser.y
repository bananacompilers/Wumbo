%{
/* C headers e funções auxiliares */
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

/* Declarações de tokens e precedência */
%token KW_BEGIN KW_END KW_FUNCTION KW_MAIN
%token KW_INT KW_FLOAT KW_CHAR
%token KW_WHILE
%token INPUT OUTPUT RETURN
%token ID NUM STRING
%token OP_ADD OP_SUB OP_MUL OP_DIV OP_EQ OP_NE OP_LT OP_GT OP_QMARK OP_ASSIGN
%token SEMI COMMA COLON LPAREN RPAREN LBRACE RBRACE
%token COMMENT

/* Definição de precedência opcional */
%left OP_ADD OP_SUB
%left OP_MUL OP_DIV

%start programa

%%

/* ==================== GRAMÁTICA ==================== */

programa
    : KW_BEGIN lista_funcoes KW_END
        { printf("Programa reconhecido com sucesso!\n"); }
    ;

lista_funcoes
    : /* vazio */
    | lista_funcoes funcao
    ;

funcao
    : KW_FUNCTION id_ou_main COLON bloco
    ;

id_ou_main
    : KW_MAIN
    | ID
    ;

bloco
    : lista_comandos
    ;

lista_comandos
    : /* vazio */
    | lista_comandos comando
    ;

comando
    : declaracao
    | atribuicao
    | entrada
    | saida
    | while_stmt
    | retorno
    | comentario
    ;

declaracao
    : tipo lista_decl SEMI
    ;

tipo
    : KW_INT
    | KW_FLOAT
    | KW_CHAR
    ;

lista_decl
    : ID opt_init decl_cont
    ;

decl_cont
    : /* vazio */
    | COMMA lista_decl
    ;

opt_init
    : /* vazio */
    | OP_ASSIGN expressao
    ;

atribuicao
    : ID OP_ASSIGN expressao SEMI
    ;

entrada
    : INPUT ID SEMI
    ;

saida
    : OUTPUT expressao SEMI
    ;

while_stmt
    : KW_WHILE LPAREN expressao RPAREN LBRACE bloco RBRACE
    ;

retorno
    : RETURN expressao SEMI
    ;

comentario
    : COMMENT
    ;

expressao
    : termo
    | expressao operador termo
    ;

termo
    : ID
    | NUM
    | STRING
    ;

operador
    : OP_ADD
    | OP_SUB
    | OP_MUL
    | OP_DIV
    | OP_EQ
    | OP_NE
    | OP_LT
    | OP_GT
    | OP_QMARK
    ;

%%

/* ==================== C CODE SECTION ==================== */

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe: %s\n", s);
}

int main(void) {
    return yyparse();
}
