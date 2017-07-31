/* GRUPO 01 - TP LOGICO Programadores */
/* PARTE 1 */

/* Requerimientos Basicos */
/* Punto 1 */
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

/* Punto 2 */
/*
a. programaEn(isabel, Lenguaje).
b. programaEn(Persona, java).
c. programaEn(_, assembler).
d. programaEn(isabel, _).
e. trabajaDe(isabel, Rol).
f. programaEn(Persona, _).
g. trabajaDe(_, proyectLeader).
*/

/* Punto 3: Proyectos */
proyecto(sumatra, java).
proyecto(sumatra, net).
proyecto(prometeus, cobol).

trabajaEn(isabel, prometeus).
trabajaEn(santiago, prometeus).
trabajaEn(julieta, sumatra).
trabajaEn(marcos, sumatra).
trabajaEn(andres, sumatra).

proyectoCorrecto(Persona, Proyecto):- trabajaEn(Persona, Proyecto), proyecto(Proyecto, Lenguaje), programaEn(Persona, Lenguaje).
proyectoCorrecto(Persona, Proyecto):- trabajaEn(Persona, Proyecto), trabajaDe(Persona, analistaFuncional).
proyectoCorrecto(Persona, Proyecto):- trabajaEn(Persona, Proyecto), trabajaDe(Persona, proyectLeader).

/* Punto 3.1: Casos de Prueba*/
/*
a. proyecto(sumatra, Lenguaje).
b. proyecto(prometeus, Lenguaje), not(Lenguaje = cobol).
c. trabajaEn(isabel, prometeus).
d. trabajaEn(santiago, prometeus).
e. trabajaEn(Persona, sumatra).
f. proyectoCorrecto(Persona, sumatra).
g. proyectoCorrecto(Persona, prometeus).
h. proyectoCorrecto(Persona, _).
i. proyectoCorrecto(_, Proyecto).
*/