creeEn(gabriel,campanita).
creeEn(gabriel,magoDeOz).
creeEn(gabriel,cavenaghi).
creeEn(juan,conejoDePascua).
creeEn(macarena,reyesMagos).
creeEn(macarena,magoCapria).
creeEn(macarena,campanita).

quiereSer(gabriel,ganarLoteria([5,9])).
quiereSer(gabriel,futbolista(arsenal)).
quiereSer(juan,cantante(1000)).
quiereSer(macarena,cantante(10000)).

equipoChico(arsenal).
equipoChico(aldosivi).

estaEnfermo(campanitas).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

esAmigo(campanita,reyesMagos).
esAmigo(campanita,conejoDePascua).
esAmigo(conejoDePascua,cavenaghi).

sonAmigos(Personaje1,Personaje2):-esAmigo(Personaje1,Personaje2).
sonAmigos(Personaje1,Personaje2):-esAmigo(Personaje2,Personaje1).

esAmbicioso(Persona):-
    quiereSer(Persona,_),
    findall(NumeroDificultad,dificultadSuenio(Persona,NumeroDificultad),TotalDificultades),
    sumlist(TotalDificultades,Total),
    Total > 20.


dificultadSuenio(Persona,NumeroDificultad):-
    quiereSer(Persona,cantante(CantidadDiscos)),
    condicionCantidadDeDiscos(CantidadDiscos,NumeroDificultad).
    

dificultadSuenio(Persona,NumeroDificultad):-
    quiereSer(Persona,ganarLoteria(Numeros)),
    length(Numeros,CantidadNumeros),
    NumeroDificultad is CantidadNumeros * 10.

dificultadSuenio(Persona,NumeroDificultad):-
    quiereSer(Persona,futbolista(Equipo)),
    condicionTamanioEquipo(Equipo,NumeroDificultad).

condicionCantidadDeDiscos(CantidadDiscos,6):-CantidadDiscos >= 500000.
condicionCantidadDeDiscos(CantidadDiscos,4):-CantidadDiscos < 500000.

condicionTamanioEquipo(Equipo,3):- equipoChico(Equipo).
condicionTamanioEquipo(Equipo,16):- not(equipoChico(Equipo)).

tieneQuimica(campanita,Persona):-
    creeEn(Persona,campanita),
    dificultadSuenio(Persona,NumeroDificultad),
    NumeroDificultad < 5.

tieneQuimica(Personaje,Persona):-
    creeEn(Persona,Personaje),
    quiereSer(Persona,Suenio),
    suenioPuro(Suenio),
    not(esAmbicioso(Persona)).

suenioPuro(futbolista(_)).
suenioPuro(cantante(CantidadDiscos)):-  CantidadDiscos < 200000.
    
puedeAlegrar(Personaje,Persona):-
    quiereSer(Persona,_),
    tieneQuimica(Personaje,Persona),
    condicionEnfermedad(Personaje).

condicionEnfermedad(Personaje):- not(estaEnfermo(Personaje)).
condicionEnfermedad(Personaje):- 
    personajeBackup(Personaje,OtroPersonaje),
    not(estaEnfermo(OtroPersonaje)).

personajeBackup(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,OtroPersonaje).

personajeBackup(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,UnPersonaje),
    sonAmigos(UnPersonaje,OtroPersonaje).




:- begin_tests(punto2).

test(gabriel_es_ambicioso,nondet) :-
	esAmbicioso(gabriel).

test(juan_no_es_ambicioso, fail):-
    esAmbicioso(juan).

test(macarena_no_es_ambiciosa, fail):-
    esAmbicioso(macarena).
		
:- end_tests(punto2).



:- begin_tests(punto3).

test(campanita_tiene_quimica_con_gabriel,nondet):-
    tieneQuimica(campanita,gabriel).

test(reyesMagos_tiene_quimica_con_macarena,nondet):-
    tieneQuimica(reyesMagos,macarena).

test(reyesMagos_tiene_quimica_con_macarena,nondet):-
    tieneQuimica(magoCapria,macarena).

test(reyesMagos_tiene_quimica_con_macarena,nondet):-
    tieneQuimica(campanita,macarena).

:- end_tests(punto3).




:- begin_tests(punto4).

test(magoCapria_alegra_a_macarena,nondet):-
    puedeAlegrar(magoCapria,macarena).

test(campanita_alegra_a_macarena,nondet):-
    puedeAlegrar(campanita,macarena).


:- end_tests(punto4).