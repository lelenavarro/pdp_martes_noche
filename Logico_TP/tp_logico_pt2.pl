/* GRUPO 01 - TP LOGICO Programadores */
/* PARTE 1 */
/* Primera Devolución */

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
trabajaDe(andres, projectLeader).

esProgramador(Persona):- programaEn(Persona, _).

/* Punto 2 */
/*
programaEn(isabel, Lenguaje).
programaEn(Persona, java).
programaEn(Persona, assembler).
esProgramador(isabel).
trabajaDe(isabel, Rol).
esProgramador(Persona).
trabajaDe(Persona, projectLeader).
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
proyectoCorrecto(Persona, Proyecto):- trabajaEn(Persona, Proyecto), trabajaDe(Persona, projectLeader).

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

bienAsignado(Proyecto):- proyecto(Proyecto, _), forall(trabajaEn(Persona, Proyecto), proyectoCorrecto(Persona, Proyecto)).

muchosLeaders(Proyecto):- trabajaEn(Persona,Proyecto), trabajaEn(Persona2,Proyecto), trabajaDe(Persona,projectLeader), trabajaDe(Persona2,projectLeader), Persona \= Persona2.

bienDefinido(Proyecto):- proyecto(Proyecto, _), bienAsignado(Proyecto), trabajaEn(Persona,Proyecto), trabajaDe(Persona,projectLeader), not(muchosLeaders(Proyecto))..
	
/* Punto 6: ¿Te Copas? */

esCopadoCon(isabel, santiago).
esCopadoCon(santiago, julieta).
esCopadoCon(santiago, marcos).
esCopadoCon(julieta, andres).

persona(Persona):- programaEn(Persona, _).
persona(Persona):- trabajaDe(Persona, _).
	
esCopadoConOtros(Persona, OtraPersona):- esCopadoCon(Persona, OtraPersona).
esCopadoConOtros(Persona, OtraPersona):- esCopadoCon(Persona, OtraMas), esCopadoConOtros(OtraMas, OtraPersona).

canTeach(Persona, Alguien, Lenguaje):- persona(Alguien), programaEn(Persona, Lenguaje), not(programaEn(Alguien, Lenguaje)), esCopadoConOtros(Persona, Alguien).
	
/* Punto 6.1 */
/*
1. esCopadoCon(isabel, santiago).
2. esCopadoCon(isabel, julieta).
3. canTeach(isabel, Persona, cobol).
4. canTeach(isabel, _, haskell).
5. canTeach(Instructor, andres, java).
6. canTeach(isabel, Persona, Lenguaje).
7. canTeach(marcos, _, _).
*/

/* Punto 7: Seniority */

/* Base de Conocimiento */
tarea(isabel , evolutiva(compleja)). 
tarea(isabel, correctiva(8, brainfuck)).
tarea(isabel, algoritmica(150)).
tarea(marcos, algoritmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)).
 
puntosSenior(evolutiva(compleja), 5).
puntosSenior(evolutiva(simple), 3).

puntosSenior(correctiva(CantidadDeLineas, _), 4) :- CantidadDeLineas > 50.
puntosSenior(correctiva(_, brainfuck), 4).

puntosSenior(algoritmica(CantidadDeLineas), Puntos) :- Puntos is CantidadDeLineas / 10.

puntosDe(Persona,Puntos):-tarea(Persona, Tarea), puntosSenior(Tarea, Puntos).

gradoSenior(Persona, GradoDeSeniority) :- persona(Persona), findall(Puntos, puntosDe(Persona,Puntos), ListaDePuntos), sumlist(ListaDePuntos, GradoDeSeniority).
/* Punto 7.1 */
/*
gradoSenior(isabel, Puntos).
gradoSenior(Persona, 0).
gradoSenior(julieta, 6).
gradoSenior(julieta, 7).
*/
