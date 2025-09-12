# 📌 Projeto de Compiladores – Mini-Compilador

**Disciplina:** Compiladores — UFT  
**Integrantes:** João Pedro Ribeiro Dias Moraes, Daniel, Eduardo Henrique, Vitor Ferreira Leal

---

## 📖 Descrição
Este projeto implementa um **mini-compilador** para uma linguagem de pequeno porte, definida em sala de aula.  
O objetivo é consolidar os conceitos de **linguagens formais, autômatos, análise léxica e sintática**, implementando gradualmente cada etapa de um compilador.

### 🔡 Definição da Linguagem (até agora)
- **Alfabeto**:  
  Σ = { A…Z, 0…9, +, −, ∗, =, <, >, !, ?, ;, ,, (, ), {, }, /, espaço, quebra de linha }  

- **Tokens definidos**:  
  - **Identificadores** → `[A-Z][A-Z-]*`  
  - **Números inteiros** → `0 | [1-9][0-9]*`  
  - **Palavras-chave** → `INT, FLOAT, CHAR, FUNCTION, MAIN, BEGIN, END, WHILE`  
  - **Operadores relacionais** → `>, <, ==, !=`  
  - **Operadores aritméticos** → `+, -, *, /`  
  - **Operador lógico** → `?`  
  - **Operador de atribuição** → `=`  
  - **Delimitadores** → `; , ( ) { }`  
  - **Comentários** → (regra em definição)

---

## 💻 Pré-requisitos

Antes de rodar o projeto, instale:

- [**MSYS2**](https://www.msys2.org/) (recomendado) ou [**WinLibs**](https://winlibs.com/) no Windows.  
- Pacotes necessários (instale no MSYS2 MinGW64 ou UCRT64):
  ```bash
  pacman -S --needed flex bison mingw-w64-x86_64-gcc make
  ```
- Alternativamente, no Linux/WSL:
  ```bash
  sudo apt update
  sudo apt install build-essential flex bison make
  ```

Verifique se estão acessíveis:
```bash
flex --version
gcc --version
```

---

## 🛠️ Estrutura do Projeto
```
Compiladores/
│── Wumbo/
│   ├── lexer.l         # Definição do analisador léxico (Flex)
│   ├── lex.yy.c        # Código gerado automaticamente pelo Flex
│   ├── wumbo-lexer     # Executável do lexer (após compilação)
│   └── examples/       # Exemplos de programas na linguagem
│       ├── hello.w
│       ├── add.w
│       └── inputs.w
└── README.md
```

---

## ▶️ Como Compilar e Executar

### 🔹 No **MSYS2 (MinGW64/UCRT64)**
1. Entre na pasta do projeto:
   ```bash
   cd /c/Users/eduar/Documents/GitHub/Compiladores/Wumbo
   ```
2. Gere o código C a partir do lexer:
   ```bash
   flex lexer.l
   ```
   → Isso cria o arquivo `lex.yy.c`.
3. Compile com GCC:
   ```bash
   gcc lex.yy.c -o wumbo-lexer
   ```
4. Rode o analisador em um exemplo:
   ```bash
   ./wumbo-lexer < examples/hello.w
   ```

### 🔹 No **PowerShell (Windows)**
O PowerShell não aceita `<`, então use:
```powershell
Get-Content -Raw .\examples\hello.w | .\wumbo-lexer.exe
```

---

## ✅ Saída Esperada
O lexer converte o código-fonte em **tokens**.  
Exemplo com `hello.w`:

```text
<KW_BEGIN,BEGIN>
<KW_FUNCTION,FUNCTION>
<ID,MAIN>
<LPAREN,(>
<RPAREN,)>
...
<KW_END,END>
```

---

## 📅 Próximos Passos
- [ ] Finalizar regras de **comentários**.  
- [ ] Implementar o **parser** (provavelmente com Bison).  
- [ ] Construir a **AST** (Árvore Sintática Abstrata).  
- [ ] Gerar código intermediário.  