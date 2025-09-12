BEGIN /: necessário para começar o programa :/
FUNCTION MAIN: /: função principal, sem isso o programa não roda. :/
    OUTPUT "HELLO WORLD!"; /: OUTPUT comando para imprimir :/
    OUTPUT "WHAT'S YOUR NAME?"; /: Aspas duplas :/
    INPUT  NAME; /: INPUT, comando para o usuário digitar :/
    OUTPUT "HELLO," + NAME;
END /: necessário para finalizar o programa :/

'/:' e ':/' são para criar comentários.
Tudo que vem depois do END é ignorado pelo compilador.
