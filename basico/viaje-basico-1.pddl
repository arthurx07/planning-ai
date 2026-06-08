(define (problem viaje-basico-1)
    (:domain agencia-viajes)

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
        (= (hoteles-reservados) 0)
    )

    (:goal (and
        (>= (ciudades-visitadas) 3)
        ;; Si hay el mismo número de hoteles 
        ;; que de ciudades visitadas, garantizamos que no falta ninguno.
        (= (ciudades-visitadas) (hoteles-reservados))
    ))
)