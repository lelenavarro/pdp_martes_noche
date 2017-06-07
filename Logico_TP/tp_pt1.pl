/* GRUPO 01 - TP LOGICO PARTE 01 */

/* Requerimientos Basicos */
/* Punto 01 */
programaEn(isabel, cobol).
programaEn(isabel, visualBasic).
programaEn(isabel, java).
programaEn(julieta, java).
programaEn(marcos, java).
/*programaEn(julieta, go) no se sabe */
programaEn(santiago, java).
programaEn(santiago, ecmaScript).

trabajaDe(isabel, analistaFuncional).
trabajaDe(andres, proyectLeader).

esProgramador(Persona):- programaEn(Persona, _).

/* Punto 02 */
/*
programaEn(isabel, Lenguaje).
programaEn(Persona, java).
programaEn(Persona, assembler).
esProgramador(isabel).
trabajaDe(isabel, Rol).
esProgramador(Persona).
trabajaDe(Persona, proyectLeader).
*/

/* Proyectos */
/* Punto 01 */
proyecto(sumatra, [java, net]).
proyecto(prometeus, [cobol]).

trabajaEn(isabel, prometeus).
trabajaEn(santiago, prometeus).
trabajaEn(julieta, sumatra).
trabajaEn(marcos, sumatra).
trabajaEn(andres, sumatra).

/* Punto 02 */