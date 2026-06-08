(define (domain agencia-viajes-ext3)
    (:requirements :typing :fluents :negative-preconditions)

    (:types
        ciudad hotel - object
    )

    (:predicates
        (viaje-por-empezar)
        (viaje-finalizado)
        (conectada ?c1 - ciudad ?c2 - ciudad)
        (en-ciudad ?h - hotel ?c - ciudad)
        (en-actual ?c - ciudad)
        (visitada ?c - ciudad)
        (tiene-hotel ?c - ciudad)
    )

    (:functions
        (ciudades-visitadas)

        ;; FUNCIONES DE TIEMPO (Heredadas de Extensión 1)
        (dias-en ?c - ciudad)
        (min-dias ?c - ciudad)
        (max-dias ?c - ciudad)
        (dias-totales)

        ;; FUNCIONES ECONÓMICAS (Extensión 3)
        (precio-vuelo ?origen - ciudad ?destino - ciudad)
        (precio-hotel ?h - hotel)
        (presupuesto-gastado)
    )

    (:action empezar-viaje
        :parameters (?c - ciudad)
        :precondition (and (viaje-por-empezar))
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
            (not (viaje-finalizado))
            (en-actual ?c)
            (en-ciudad ?h ?c)
            (not (tiene-hotel ?c))
        )
        :effect (and
            (tiene-hotel ?c)
            ;; La reserva no suma coste: el hotel se paga por noche en pasar-dia.
        )
    )

    (:action pasar-dia
        :parameters (?c - ciudad ?h - hotel)
        :precondition (and
            (not (viaje-finalizado))
            (en-actual ?c)
            (en-ciudad ?h ?c)
            (tiene-hotel ?c)
            (< (dias-en ?c) (max-dias ?c))
        )
        :effect (and
            (increase (dias-en ?c) 1)
            (increase (dias-totales) 1)
            (increase (presupuesto-gastado) (precio-hotel ?h))      ; El coste se acumula por noche en hotel
        )
    )

    (:action volar
        :parameters (?origen - ciudad ?destino - ciudad)
        :precondition (and
            (not (viaje-finalizado))
            (en-actual ?origen)
            (conectada ?origen ?destino)
            (not (visitada ?destino))
            (tiene-hotel ?origen)            ; Si vuela a una ciudad, debe reservar hotel
            (>= (dias-en ?origen) (min-dias ?origen))
        )
        :effect (and
            (not (en-actual ?origen))
            (en-actual ?destino)
            (visitada ?destino)
            (increase (ciudades-visitadas) 1)
            ;; Sumamos el precio del vuelo al presupuesto
            (increase (presupuesto-gastado) (precio-vuelo ?origen ?destino))
        )
    )

    (:action terminar-viaje
        :parameters (?c - ciudad)
        :precondition (and
            (not (viaje-finalizado))
            (en-actual ?c)
            (tiene-hotel ?c)
            (>= (dias-en ?c) (min-dias ?c))
        )
        :effect (and
            (viaje-finalizado)
        )
    )
)
