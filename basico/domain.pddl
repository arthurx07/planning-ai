(define (domain agencia-viajes)
    (:requirements :typing :fluents :negative-preconditions)

    (:types
        ciudad hotel - object
    )

    (:predicates
        (viaje-por-empezar)
        (conectada ?c1 - ciudad ?c2 - ciudad)
        (en-ciudad ?h - hotel ?c - ciudad)
        (en-actual ?c - ciudad)
        (visitada ?c - ciudad)
        (tiene-hotel ?c - ciudad)
    )

    (:functions
        (ciudades-visitadas)
        (hoteles-reservados) 
    )

    (:action empezar-viaje
        :parameters (?c - ciudad)
        :precondition (and 
            (viaje-por-empezar)
        )
        :effect (and 
            (not (viaje-por-empezar))
            (en-actual ?c)
            (visitada ?c)
            (increase (ciudades-visitadas) 1)
        )
    )

    (:action reservar-hotel
        :parameters (?h - hotel ?c - ciudad)
        :precondition (and 
            (en-actual ?c)
            (en-ciudad ?h ?c)
            (not (tiene-hotel ?c))
        )
        :effect (and 
            (tiene-hotel ?c)
            (increase (hoteles-reservados) 1)
        )
    )

    (:action volar
        :parameters (?origen - ciudad ?destino - ciudad)
        :precondition (and 
            (en-actual ?origen)
            (conectada ?origen ?destino)
            (not (visitada ?destino))
            (tiene-hotel ?origen)
        )
        :effect (and 
            (not (en-actual ?origen))
            (en-actual ?destino)
            (visitada ?destino)
            (increase (ciudades-visitadas) 1)
        )
    )
)