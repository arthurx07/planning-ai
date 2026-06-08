(define (problem viaje-ext2-1)
    (:domain agencia-viajes-ext2)

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

        (= (ciudades-visitadas) 0)
        (= (dias-totales) 0)
        (= (interes-total) 0)

        (= (dias-en madrid) 0)
        (= (dias-en barcelona) 0)
        (= (dias-en paris) 0)
        (= (dias-en roma) 0)

        (= (min-dias madrid) 1)
        (= (max-dias madrid) 3)
        (= (min-dias barcelona) 2)
        (= (max-dias barcelona) 4)
        (= (min-dias paris) 3)
        (= (max-dias paris) 5)
        (= (min-dias roma) 2)
        (= (max-dias roma) 3)

        ;; VALORES DE INTERÉS (1 = Mayor interés, 3 = Menor interés)
        (= (interes madrid) 1)
        (= (interes barcelona) 2)
        (= (interes paris) 3)
        (= (interes roma) 1)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)
        (>= (dias-totales) 8)
    ))

    ;; OPTIMIZACIÓN DE MÉTRICA
    (:metric minimize (interes-total))
)
