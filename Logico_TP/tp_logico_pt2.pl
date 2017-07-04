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
programaEn(isabel, Lenguaje).
programaEn(Persona, java).
programaEn(Persona, assembler).
esProgramador(isabel).
trabajaDe(isabel, Rol).
esProgramador(Persona).
trabajaDe(Persona, proyectLeader).
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
b. proyecto(prometeus, Lenguaje), Lenguaje \= cobol.
c. trabajaEn(isabel, prometeus).
d. trabajaEn(santiago, prometeus).
e. trabajaEn(Persona, sumatra).
f. proyectoCorrecto(Persona, sumatra).
g. proyectoCorrecto(Persona, prometeus).
h. proyectoCorrecto(Persona, _).
i. proyectoCorrecto(_, Proyecto).
*/

/* Punto 4: Validación de Proyectos */
bienDefinido(Proyecto):- trabajaEn(Persona, Proyecto), trabajaEn(Persona2, Proyecto), proyectoCorrecto(Persona, Proyecto), proyectoCorrecto(Persona2, Proyecto), trabajaDe(Persona, proyectLeader), trabajaDe(Persona2, proyectLeader), not(Persona \= Persona2).
	
/* Punto 6: ¿Te Copas? */
esCopadoCon(isabel, santiago).
esCopadoCon(santiago, julieta).
esCopadoCon(santiago, marcos).
esCopadoCon(julieta, andres).

persona(Persona):- programaEn(Persona, _).
persona(Persona):- trabajaDe(Persona, _).
	
esCopadoConOtros(Persona, X):- esCopadoCon(Persona, X).
esCopadoConOtros(Persona, X):- persona(X), esCopadoCon(Persona, Y), esCopadoConOtros(Y, X).

canTeach(Persona, Alguien, Lenguaje):- persona(Alguien), programaEn(Persona, Lenguaje), not(programaEn(Alguien, Lenguaje)), esCopadoConOtros(Persona, Alguien).
	
/* Punto 6.1 */
/*
1. esCopadoCon(isabel, santiago).
2. esCopadoCon(isabel, julieta).
3. canTeach(isabel, Persona, cobol).
4. canTeach(isabel, Alguien, haskell).
5. canTeach(Profe, andres, java).
6. canTeach(isabel, Persona, Lenguaje).
7. canTeach(marcos, Persona, Lenguaje).
*/

