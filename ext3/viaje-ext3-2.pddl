(define (problem viaje-ext3-2)
    (:domain agencia-viajes-ext3)

    (:objects
        origen barato1 barato2 caro1 caro2 - ciudad
        h-origen h-b1 h-b2 h-c1 h-c2 - hotel
    )

    (:init
        (viaje-por-empezar)

        (en-ciudad h-origen origen)
        (en-ciudad h-b1 barato1)
        (en-ciudad h-b2 barato2)
        (en-ciudad h-c1 caro1)
        (en-ciudad h-c2 caro2)

        ;; Mix de Hoteles baratos/caros
        (conectada origen barato1) (conectada barato1 origen)
        (conectada barato1 caro1) (conectada caro1 barato1)

        ;; Hoteles caros
        (conectada origen caro2) (conectada caro2 origen)

        (= (ciudades-visitadas) 0)
        (= (dias-totales) 0)
        (= (presupuesto-gastado) 0)

        (= (dias-en origen) 0) (= (dias-en barato1) 0) (= (dias-en barato2) 0)
        (= (dias-en caro1) 0) (= (dias-en caro2) 0)

        (= (min-dias origen) 1) (= (max-dias origen) 2)
        (= (min-dias barato1) 1) (= (max-dias barato1) 2)
        (= (min-dias barato2) 1) (= (max-dias barato2) 2)
        (= (min-dias caro1) 1) (= (max-dias caro1) 2)
        (= (min-dias caro2) 1) (= (max-dias caro2) 2)

        ;; Rama de Alojamientos Económicos (Vuelos costosos de 100, pero hotel a 20/noche)
        (= (precio-vuelo origen barato1) 100)
        (= (precio-vuelo barato1 caro1) 100)
        (= (precio-hotel h-origen) 20)
        (= (precio-hotel h-b1) 20)

        ;; Rama de Alojamientos Caros (Vuelos de saldo a 10, pero hotel a 300/noche)
        (= (precio-vuelo origen caro2) 10)
        (= (precio-hotel h-c2) 300)

        ;; La ciudad de destino final de la ruta óptima tiene precio de hotel alto
        (= (precio-hotel h-c1) 300)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)
        (>= (dias-totales) 3)

        ;; Rango de presupuesto flexible para permitir la libre optimización
        (>= (presupuesto-gastado) 100)
        (<= (presupuesto-gastado) 2000)
    ))

    (:metric minimize (presupuesto-gastado))
)
