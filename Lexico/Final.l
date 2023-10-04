%{
/*
Compiladores Grupo 3
Analizador Lexico
Genaro Vidal Hèctor
Màrquez Rosas Axel Noè

*/

/*Definiciones, variables y archivos*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

//Archivos para las tablas de salida (tokens, literales, errores, simbolos)
FILE *tokenSal, *litSal, *errSal, *tabSimb;

//Variables para el llenado de tablas en los archivos
int valorNum=0, valorId=0, valorCad=0;

//Funciones para guardar en el archivo los tokens, en las mismas funciones 
//se les asigna su clase y valor, solo se verifica con strcmp que simbolo empata para elegir que guardar.

// Función para tokens de operadores aritméticos
void tokenArit() {
    if (strcmp(yytext, "+") == 0) {
        fprintf(tokenSal, "(0,43)\n\n");
    } else if (strcmp(yytext, "-") == 0) {
        fprintf(tokenSal, "(0,45)\n\n");
    } else if (strcmp(yytext, "*") == 0) {
        fprintf(tokenSal, "(0,42)\n\n");
    } else if (strcmp(yytext, "/") == 0) {
        fprintf(tokenSal, "(0,47)\n\n");
    } else if (strcmp(yytext, "%") == 0) {
        fprintf(tokenSal, "(0,37)\n\n");
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para tokens de operadores lógicos
void tokenLog() {
    if (strcmp(yytext, "&&") == 0) {
        fprintf(tokenSal, "(1,0)\n\n");
    } else if (strcmp(yytext, "||") == 0) {
        fprintf(tokenSal, "(1,1)\n\n");
    } else if (strcmp(yytext, "!") == 0) {
        fprintf(tokenSal, "(1,2)\n\n");
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para tokens de operadores relacionales
void tokenRel() {
    if (strcmp(yytext, "==") == 0) {
        fprintf(tokenSal, "(2,0)\n\n");
    } else if (strcmp(yytext, "!=") == 0) {
        fprintf(tokenSal, "(2,1)\n\n");
    } else if (strcmp(yytext, ">") == 0) {
        fprintf(tokenSal, "(2,2)\n\n");
    } else if (strcmp(yytext, "<") == 0) {
        fprintf(tokenSal, "(2,3)\n\n");
    } else if (strcmp(yytext, ">=") == 0) {
        fprintf(tokenSal, "(2,4)\n\n");
    } else if (strcmp(yytext, "<=") == 0) {
        fprintf(tokenSal, "(2,5)\n\n");
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para tokens de números
void tokenNum() {
    fprintf(tokenSal, "(3,%d)\n\n", valorNum);
    valorNum++;
}

// Función para tokens de palabras reservadas
void tokenReserv() {
    if (strcmp(yytext, "assinado") == 0) {
        fprintf(tokenSal, "(4,0)\n\n");
    } else if (strcmp(yytext, "caso") == 0) {
        fprintf(tokenSal, "(4,1)\n\n");
    } else if (strcmp(yytext, "enquanto") == 0) {
        fprintf(tokenSal, "(4,2)\n\n");
    } else if (strcmp(yytext, "fazer") == 0) {
        fprintf(tokenSal, "(4,3)\n\n");
    } else if (strcmp(yytext, "flutuador") == 0) {
        fprintf(tokenSal, "(4,4)\n\n");
    } else if (strcmp(yytext, "inteiro") == 0) {
        fprintf(tokenSal, "(4,5)\n\n");
    } else if (strcmp(yytext, "para") == 0) {
        fprintf(tokenSal, "(4,6)\n\n");
    } else if (strcmp(yytext, "quebrar") == 0) {
        fprintf(tokenSal, "(4,7)\n\n");
    } else if (strcmp(yytext, "retorno") == 0) {
        fprintf(tokenSal, "(4,8)\n\n");
    } else if (strcmp(yytext, "se") == 0) {
        fprintf(tokenSal, "(4,9)\n\n");
    } else if (strcmp(yytext, "trocar") == 0) {
        fprintf(tokenSal, "(4,10)\n\n");
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para tokens de identificadores
void tokenId() {
    fprintf(tokenSal, "(5,%d)\n\n", valorId);
    fprintf(tabSimb, "Pos: %d\t Nombre: %s    Tipo: -1\n", valorId, yytext);

    valorId++;
}

// Función para tokens de símbolos especiales donde se convierte el valor de 
// yytext en un valor numerico para saber que ascii tiene
void tokenEsp() {
    if (strcmp(yytext, "(") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, ")") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, "{") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, "}") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, ";") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, ",") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, "[") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, "]") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, ":") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else if (strcmp(yytext, "#") == 0) {
        fprintf(tokenSal, "(6,%d)\n\n", (int)yytext[0]);
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para tokens de operadores de asignación
void tokenAsig() {
    if (strcmp(yytext, "=") == 0) {
        fprintf(tokenSal, "(7,0)\n\n");
    } else if (strcmp(yytext, "+=") == 0) {
        fprintf(tokenSal, "(7,1)\n\n");
    } else if (strcmp(yytext, "-=") == 0) {
        fprintf(tokenSal, "(7,2)\n\n");
    } else if (strcmp(yytext, "*=") == 0) {
        fprintf(tokenSal, "(7,3)\n\n");
    } else if (strcmp(yytext, "/=") == 0) {
        fprintf(tokenSal, "(7,4)\n\n");
    } else if (strcmp(yytext, "%=") == 0) {
        fprintf(tokenSal, "(7,5)\n\n");
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para tokens de constantes de cadena
void tokenConsCad() {
    
    fprintf(tokenSal, "(8,%d)\n\n", valorCad);
    
}

// Función para tokens de operadores de cadena
void tokenCad() {
    if (strcmp(yytext, "&") == 0) {
        fprintf(tokenSal, "(9,0)\n\n");
    } else if (strcmp(yytext, "like") == 0) {
        fprintf(tokenSal, "(9,1)\n\n");
    } else {
        fprintf(tokenSal, "Opción no reconocida)\n\n");
    }
}

// Función para registro de constantes de cadena en litSalida.txt
void litConsCad() {
    
    fprintf(litSal, "Posicion: %d\n\n", valorCad); // Guarda en el archivo la posicion y el valor
    valorCad++;
}

%}

/*Componentes lexicos */

letmin [a-z]
letMay [A-Z]
dig [0-9]
num {dig}+

opa [+\-*/%]
opl &&|(\|\|)|!
opr (=|>|<|!)=|>|<
coNu {num}|\(-{num}\)|\(\+{num}\)
palr assinado|caso|enquanto|fazer|flutuador|inteiro|para|quebrar|retorno|se|trocar
sime [;,:#]|\(|\)|\{|\}|\[|\]
opc &|like
coCa \"[^\"]*\"
ident _({letmin}|{letMay})({letmin}|{letMay}|{dig}|_)*
opas {opa}?=

%%



{opa}   { fprintf(tokenSal, "Es un operador aritmético: %s\n", yytext); tokenArit(); } // Se llena el archivo tokenSal de todo lo que encuentre correctamente
{opl}   { fprintf(tokenSal, "Es un operador lógico: %s\n", yytext); tokenLog(); }
{opr}   { fprintf(tokenSal, "Es un operador relacional: %s\n", yytext); tokenRel(); }
{coNu}  { fprintf(tokenSal, "Es una constante numérica: %s\n", yytext); tokenNum(); }
{palr}  { fprintf(tokenSal, "Es una palabra reservada: %s\n", yytext); tokenReserv(); }
{ident} { fprintf(tokenSal, "Es un identificador: %s\n", yytext); tokenId(); }
{sime}  { fprintf(tokenSal, "Es un símbolo especial: %s\n", yytext); tokenEsp(); }
{opas}  { fprintf(tokenSal, "Es un operador de asignación: %s\n", yytext); tokenAsig(); } 
{coCa}  { fprintf(tokenSal, "Es una cadena constante: %s\n", yytext); tokenConsCad();
            fprintf(litSal, "Cadena: %s\n", yytext); litConsCad(); } // Para el llenado de la tabla de literales
{opc}   { fprintf(tokenSal, "Es un operador de cadena: %s\n", yytext); tokenCad(); }

[ \t\n]+    { /* Ignora espacios en blanco, tabuladores y saltos de línea */ }
.           { fprintf(errSal, "Carácter no reconocido: %s\n", yytext); } // para la tabla de errores o no reconocidos



%%


int main(int argc, char *argv[])
{
    // Verificar si se proporcionó un argumento de línea de comandos (nombre del archivo de entrada)
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <archivo_de_entrada>\n", argv[0]);
        return 1;
    }

    // Abre el archivo de entrada para lectura
    yyin = fopen(argv[1], "r");

    // Abre archivos de salida para tokens, literales de cadena, errores y tabla de símbolos
    tokenSal = fopen("tokenSalida.txt", "w");
    litSal = fopen("litSalida.txt", "w");
    errSal = fopen("errSalida.txt", "w");
    tabSimb = fopen("tabSimb.txt", "w");

    // Verifica si se abrieron 
    if (!yyin | !tokenSal | !litSal | !errSal | !tabSimb ) {
        perror("No se pudo abrir el archivo de entrada o salida");
        return 1;
    }

    yylex();
    
    // Cierro archivos
    fclose(yyin);
    fclose(tokenSal);
    fclose(litSal);
    fclose(errSal);
    fclose(tabSimb);
    

    return 0;
}
