(define (domain agencia-viajes-ext1)
    (:requirements :typing :fluents :negative-preconditions)

    (:types
        ciudad hotel - object
    )

    (:predicates
        (viaje-por-empezar)
        (viaje-finalizado)                   ; Bandera para asegurar que el viaje cierra bien
        (conectada ?c1 - ciudad ?c2 - ciudad)
        (en-ciudad ?h - hotel ?c - ciudad)
        (en-actual ?c - ciudad)
        (visitada ?c - ciudad)
        (tiene-hotel ?c - ciudad)
    )

    (:functions
        (ciudades-visitadas)
        
        ;; FUNCIONES DE TIEMPO
        (dias-en ?c - ciudad)                ; Cuántos días llevamos en una ciudad
        (min-dias ?c - ciudad)               ; Mínimo requerido en esa ciudad
        (max-dias ?c - ciudad)               ; Máximo permitido en esa ciudad
        (dias-totales)                       ; Duración total del viaje
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
            ;; OPTIMIZACIÓN: Ya no necesitamos sumar ningún contador de hoteles aquí.
        )
    )

    (:action pasar-dia
        :parameters (?c - ciudad)
        :precondition (and 
            (en-actual ?c)
            (tiene-hotel ?c)                 ; Lógico: no pasas días si no tienes dónde dormir
            (< (dias-en ?c) (max-dias ?c))   ; Límite máximo de días en la ciudad
        )
        :effect (and 
            (increase (dias-en ?c) 1)
            (increase (dias-totales) 1)
        )
    )

    (:action volar
        :parameters (?origen - ciudad ?destino - ciudad)
        :precondition (and 
            (en-actual ?origen)
            (conectada ?origen ?destino)
            (not (visitada ?destino))
            (tiene-hotel ?origen)
            (>= (dias-en ?origen) (min-dias ?origen)) ; Peaje: cumplir mínimo de días en origen
        )
        :effect (and 
            (not (en-actual ?origen))
            (en-actual ?destino)
            (visitada ?destino)
            (increase (ciudades-visitadas) 1)
        )
    )

    (:action terminar-viaje
        :parameters (?c - ciudad)
        :precondition (and 
            (en-actual ?c)
            (tiene-hotel ?c)                 ; OPTIMIZACIÓN: Obligamos a tener hotel en la última ciudad
            (>= (dias-en ?c) (min-dias ?c))  ; Comprobamos el mínimo de días de la última ciudad
        )
        :effect (and 
            (viaje-finalizado)
        )
    )
)