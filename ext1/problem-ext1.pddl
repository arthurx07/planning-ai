(define (problem viaje-ext1-1)
    (:domain agencia-viajes-ext1)

    (:objects
        madrid barcelona paris roma - ciudad
        hotel-m hotel-b hotel-p hotel-r - hotel
    )

    (:init
        (viaje-por-empezar)

        (en-ciudad hotel-m madrid)
        (en-ciudad hotel-b barcelona)
        (en-ciudad hotel-p paris)
        (en-ciudad hotel-r roma)

        (conectada madrid barcelona)
        (conectada barcelona madrid)
        (conectada barcelona paris)
        (conectada paris barcelona)
        (conectada paris roma)
        (conectada roma paris)
        (conectada madrid roma)
        (conectada roma madrid)

        ;; Inicialización de contadores globales
        (= (ciudades-visitadas) 0)
        (= (dias-totales) 0)

        ;; Inicialización de días en cada ciudad
        (= (dias-en madrid) 0)
        (= (dias-en barcelona) 0)
        (= (dias-en paris) 0)
        (= (dias-en roma) 0)

        ;; Restricciones: Mínimo y Máximo de días por ciudad
        (= (min-dias madrid) 1)
        (= (max-dias madrid) 3)

        (= (min-dias barcelona) 2)
        (= (max-dias barcelona) 4)

        (= (min-dias paris) 3)
        (= (max-dias paris) 5)

        (= (min-dias roma) 2)
        (= (max-dias roma) 3)
    )

    (:goal (and
        (viaje-finalizado)                       ; Exigimos usar la acción terminar-viaje
        (>= (ciudades-visitadas) 3)              ; Mínimo de ciudades a visitar
        (>= (dias-totales) 8)                    ; El recorrido debe durar al menos 8 días totales
    ))
)