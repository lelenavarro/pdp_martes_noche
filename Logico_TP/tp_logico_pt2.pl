/* GRUPO 01 - TP LOGICO Programadores */
/* PARTE 01 */

/* Requerimientos Basicos */
/* Punto 01 */
programaEn(fernando, cobol).
programaEn(fernando, visualBasic).
programaEn(fernando, java).
programaEn(julieta, java).
programaEn(marcos, java).
/*programaEn(julieta, go) no se sabe */
programaEn(santiago, java).
programaEn(santiago, ecmaScript).

trabajaDe(fernando, analistaFuncional).
trabajaDe(andres, proyectLeader).

esProgramador(Persona):- programaEn(Persona, _).

/* Punto 02 */
/*
programaEn(fernando, Lenguaje).
programaEn(Persona, java).
programaEn(Persona, assembler).
esProgramador(fernando).
trabajaDe(fernando, Rol).
esProgramador(Persona).
trabajaDe(Persona, proyectLeader).
*/

/* PARTE 02 */
/* Punto 02: Proyectos */
proyecto(sumatra, [java, net]).
proyecto(prometeus, [cobol]).

trabajaEn(fernando, prometeus).
trabajaEn(santiago, prometeus).
trabajaEn(julieta, sumatra).
trabajaEn(marcos, sumatra).
trabajaEn(andres, sumatra).

/* Punto 02 */