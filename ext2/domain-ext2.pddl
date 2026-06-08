(define (domain agencia-viajes-ext2)
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
        
        ;; FUNCIONES DE TIEMPO (De la Extensión 1)
        (dias-en ?c - ciudad)                ; Días transcurridos en la ciudad actual
        (min-dias ?c - ciudad)               ; Mínimo de días obligatorio
        (max-dias ?c - ciudad)               ; Máximo de días permitido
        (dias-totales)                       ; Contador global de días del viaje
        
        ;; FUNCIONES DE OPTIMIZACIÓN (De la Extensión 2)
        (interes ?c - ciudad)                ; Grado de interés (1 = Máximo, 3 = Mínimo)
        (interes-total)                      ; Acumulador numérico que optimizará metric-ff
    )

    ;; ===================================================
    ;; ACCIÓN 1: Inicializar el viaje en una ciudad libre
    ;; ===================================================
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
            (increase (interes-total) (interes ?c)) ; Sumamos el interés de la primera parada
        )
    )

    ;; ===================================================
    ;; ACCIÓN 2: Reservar alojamiento en la ciudad actual
    ;; ===================================================
    (:action reservar-hotel
        :parameters (?h - hotel ?c - ciudad)
        :precondition (and 
            (en-actual ?c)
            (en-ciudad ?h ?c)
            (not (tiene-hotel ?c))
        )
        :effect (and 
            (tiene-hotel ?c)
        )
    )

    ;; ===================================================
    ;; ACCIÓN 3: Consumir un día de estancia
    ;; ===================================================
    (:action pasar-dia
        :parameters (?c - ciudad)
        :precondition (and 
            (en-actual ?c)
            (tiene-hotel ?c)                 ; Hito fundamental: obliga a reservar antes de vivir en ella
            (< (dias-en ?c) (max-dias ?c))   ; Freno numérico para el máximo
        )
        :effect (and 
            (increase (dias-en ?c) 1)
            (increase (dias-totales) 1)
        )
    )

    ;; ===================================================
    ;; ACCIÓN 4: Viajar en avión hacia un nuevo destino
    ;; ===================================================
    (:action volar
        :parameters (?origen - ciudad ?destino - ciudad)
        :precondition (and 
            (en-actual ?origen)
            (conectada ?origen ?destino)
            (not (visitada ?destino))        ; Restricción del enunciado: no repetir ciudades
            (>= (dias-en ?origen) (min-dias ?origen)) ; Peaje temporal: cumplir días mínimos en origen
        )
        :effect (and 
            (not (en-actual ?origen))
            (en-actual ?destino)
            (visitada ?destino)
            (increase (ciudades-visitadas) 1)
            (increase (interes-total) (interes ?destino)) ; Sumamos el interés del destino
        )
    )

    ;; ===================================================
    ;; ACCIÓN 5: Validar y concluir el itinerario completo
    ;; ===================================================
    (:action terminar-viaje
        :parameters (?c - ciudad)
        :precondition (and 
            (en-actual ?c)
            (>= (dias-en ?c) (min-dias ?c))  ; Peaje temporal: cumplir días mínimos en la última ciudad
        )
        :effect (and 
            (viaje-finalizado)
        )
    )
)