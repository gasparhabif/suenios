% 1
% persona(Persona)/1
persona(gabriel).
persona(juan).
persona(macarena).
persona(diego).

% personaje(Personaje)/1
personaje(campanita).
personaje(elMagoDeOz).
personaje(conejoDePascua).
personaje(reyesMagos).
personaje(magoCapria).

% creeEn(Persona, Personaje)/2
creeEn(gabriel, campanita).
creeEn(gabriel, elMagoDeOz).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

% suenio(Persona, suenio(Sueño, ComoCumplirlo))/2
queSonio(gabriel, suenio(ganarLoteria, apostar([5,9]))).
queSonio(gabriel, suenio(futbolista, jugarEn(arsenal))).
queSonio(juan, suenio(cantante, vender(100000))).
queSonio(macarena, suenio(cantante, vender(10000))).

% 2
esEquipoChico(arsenal).
esEquipoChico(aldosivi).

esAmbiciosa(Persona) :-
    persona(Persona),
    findall(Dificultad, 
        (queSonio(Persona, Suenio), dificultadDeSuenio(Suenio, Dificultad)),
         Dificultades),
    sumlist(Dificultades, DificultadTotal),
    DificultadTotal > 20.

dificultadDeSuenio(suenio(cantante, vender(Cantidad)), Dificultad) :-
    Cantidad > 500000,
    Dificultad is 6.
dificultadDeSuenio(suenio(cantante, vender(Cantidad)), Dificultad) :-
    Cantidad =< 500000,
    Dificultad is 4.
dificultadDeSuenio(suenio(ganarLoteria, apostar(Numeros)), Dificultad) :-
    length(Numeros, CantidadApostados),
    Dificultad is CantidadApostados * 10.
dificultadDeSuenio(suenio(futbolista, jugarEn(Equipo)), Dificultad) :-
    esEquipoChico(Equipo),
    Dificultad is 3.
dificultadDeSuenio(suenio(futbolista, jugarEn(Equipo)), Dificultad) :-
    not(esEquipoChico(Equipo)),
    Dificultad is 16.

% 3
tienenQuimica(Personaje, Persona) :-
    persona(Persona),
    creeEn(Persona, Personaje),
    esUnSoniador(Persona, Personaje).

esUnSoniador(Persona, campanita) :-
    queSonio(Persona, UnSuenio),
    dificultadDeSuenio(UnSuenio, Dificultad),
    Dificultad < 5.

esUnSoniador(Persona, Personaje) :-
    Personaje \= campanita,
    not(esAmbiciosa(Persona)),
    forall(queSonio(Persona, UnSuenio), esSuenioPuro(UnSuenio)).

esSuenioPuro(suenio(futbolista, _)).
esSuenioPuro(suenio(cantante, vender(Cantidad))) :-
    Cantidad < 200000.

% 4
sonAmigos(campanita, reyesMagos).
sonAmigos(campanita, conejoDePascua).
sonAmigos(conejoDePascua, cavenaghi).

personajeDeBackUp(Personaje, BackUp) :- sonAmigos(Personaje, BackUp).
personajeDeBackUp(Personaje, BackUp) :-
    sonAmigos(Personaje, AmigoEnComun),
    personajeDeBackUp(AmigoEnComun, BackUp).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

puedeAlegrar(Personaje, Persona) :-
    persona(Persona),
    personaje(Personaje),
    daAlegrias(Personaje, Persona).

daAlegrias(_, Persona) :-
    queSonio(Persona, _).
daAlegrias(Personaje, Persona) :-
    tienenQuimica(Personaje, Persona),
    personajeSanoOConBackUp(Personaje).

personajeSanoOConBackUp(Personaje) :-
    not(estaEnfermo(Personaje)).
personajeSanoOConBackUp(Personaje) :-
    estaEnfermo(Personaje),
    personajeDeBackUp(Personaje, BackUp),
    personajeSanoOConBackUp(BackUp).
