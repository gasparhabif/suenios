% 1
% persona(Quien)/1
persona(gabriel).
persona(juan).
persona(macarena).
persona(diego).

% creeEn(Quien, Personaje)/2
creeEn(gabriel, campanita).
creeEn(gabriel, elMagoDeOz).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

% suenio(Quien, suenio(Sueño, ComoCumplirlo))/2
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