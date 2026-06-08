(define (problem viaje-ext3-4)
    (:domain agencia-viajes-ext3)

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

        ;; Grafo estándar bidireccional
        (conectada madrid barcelona) (conectada barcelona madrid)
        (conectada barcelona paris) (conectada paris barcelona)
        (conectada paris roma) (conectada roma paris)
        (conectada madrid roma) (conectada roma madrid)

        (= (ciudades-visitadas) 0)
        (= (dias-totales) 0)
        (= (presupuesto-gastado) 0)

        (= (dias-en madrid) 0) (= (dias-en barcelona) 0)
        (= (dias-en paris) 0) (= (dias-en roma) 0)

        ;; Tiempos
        (= (min-dias madrid) 1) (= (max-dias madrid) 3)
        (= (min-dias barcelona) 1) (= (max-dias barcelona) 3)
        (= (min-dias paris) 1) (= (max-dias paris) 3)
        (= (min-dias roma) 1) (= (max-dias roma) 3)

        ;; PRECIOS (Diferentes para cumplir el requisito)
        (= (precio-hotel hotel-m) 100)
        (= (precio-hotel hotel-b) 120)
        (= (precio-hotel hotel-p) 200)
        (= (precio-hotel hotel-r) 150)

        ;; Precios de vuelos de ida y vuelta (simétricos)
        (= (precio-vuelo madrid barcelona) 50) (= (precio-vuelo barcelona madrid) 50)
        (= (precio-vuelo barcelona paris) 80) (= (precio-vuelo paris barcelona) 80)
        (= (precio-vuelo paris roma) 60) (= (precio-vuelo roma paris) 60)
        (= (precio-vuelo madrid roma) 90) (= (precio-vuelo roma madrid) 90)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)
        (>= (dias-totales) 5)

        ;; Límites de precio
        ;; Presupuesto inalcanzable: el coste mínimo verificado es 710
        (>= (presupuesto-gastado) 0)
        (<= (presupuesto-gastado) 709)
    ))

    ;; Se exige minimizar el precio total
    (:metric minimize (presupuesto-gastado))
)
