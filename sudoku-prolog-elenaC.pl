% RULES

/* Primero se comparan los elementos de la lista para asegurarse de que se 
encuentran en ese rango.  
*/
range([]). % verificar si la lista esta vacia y terminar recursividad
range([H|T]) :- 
	rango(H), % verificar que elemento cabeza de lista esta en el rango
    range(T). % hacer llamado recursivo con el resto de elemento

/* En el caso que la variable esta instanciada, se comprueba en el rango 
si esta entre 1-4. Si la variable no esta instanciada le asigna un
valor valido dentro del rango.
*/
rango(X):-
	nonvar(X), % verifica si esta instanciada
	X > 0,	
	X =< 4.

rango(X):- 
	var(X),	% verifica si no esta instanciada
	num(X). % asigna un valor a la variable
% valores validos que puede tomar la variable. 1-4 	
num(1).
num(2).
num(3).
num(4).

/* Verifica si elementos de la lista son diferentes*/
diff(L):-
	length(L, N), % asigna longitud de lista L a N
	sort(L, L1), % ordena la lista L y elimina los valores duplicados. Lo asigna a L1
	!, 
	length(L1, N). /* verifica si longitud de L1 es igual a N. En el caso que no lo 
sea, hace backtrack y debido al corte se aborta el predicado */

/* verifica que en cada una de las 4 filas, los elementos son diferentes */
filas([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]) :- 
	diff([A,B,C,D]),
	diff([E,F,G,H]),
	diff([I,J,K,L]),
	diff([M,N,O,P]).

/* verifica que en cada una de las 4 columnas, los elementos son diferentes */
cols([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]) :-
	diff([A,E,I,M]),
	diff([B,F,J,N]),
	diff([C,G,K,O]),
	diff([D,H,L,P]).
	 
/* verifica que en cada una de las 4 bloques, los elementos son diferentes */
bloques([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]) :-
	diff([A,B,E,F]),
	diff([C,D,G,H]),
	diff([I,J,M,N]),
	diff([K,L,O,P]).

/* recibe una lista que corresponde a la tabla de sudoku 4x4 que queremos resolver. Verifica si las variables 
tienen valores asignados en el rango, y despues verifica que las filas, columnas y bloques no tienen valores repetidos. Imprime resultado*/
sudoku(L) :-
	range(L), 
	filas(L), 
	cols(L), 
	bloques(L),
	print_sudoku(L).
	
print_sudoku([]). % si la lista se queda vacia se termina la recursividad
/* recoge los 4 elementos iniciales de la lista y los devuelve por pantalla. Al terminar llama de nuevo a la funcion*/
print_sudoku([C1,C2,C3,C4|R]):- 
	write(C1), write('  '),
	write(C2), write('  '),
	write(C3), write('  '),
	write(C4), nl,
	print_sudoku(R).

