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

        ;; RUTA 1: Vuelos baratos, Hoteles Caros
        (conectada origen caro1) (conectada caro1 origen)
        (conectada caro1 caro2) (conectada caro2 caro1)

        ;; RUTA 2: Vuelos caros, Hoteles Baratos
        (conectada origen barato1) (conectada barato1 origen)
        (conectada barato1 barato2) (conectada barato2 barato1)

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

        ;; PRECIOS
        ;; Ruta 1: Volar cuesta solo 10, pero dormir cuesta 300
        (= (precio-vuelo origen caro1) 10) (= (precio-vuelo caro1 origen) 10)
        (= (precio-vuelo caro1 caro2) 10) (= (precio-vuelo caro2 caro1) 10)
        (= (precio-hotel h-c1) 300)
        (= (precio-hotel h-c2) 300)

        ;; Ruta 2: Volar es muy caro (100), pero dormir es casi gratis (20)
        (= (precio-vuelo origen barato1) 100) (= (precio-vuelo barato1 origen) 100)
        (= (precio-vuelo barato1 barato2) 100) (= (precio-vuelo barato2 barato1) 100)
        (= (precio-hotel h-b1) 20)
        (= (precio-hotel h-b2) 20)

        ;; El inicio tiene un precio base estándar
        (= (precio-hotel h-origen) 50)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)
        (>= (dias-totales) 3)
        ;; Rango de precios muy amplio para que pueda elegir
        (>= (presupuesto-gastado) 100)
        (<= (presupuesto-gastado) 2000)
    ))

    (:metric minimize (presupuesto-gastado))
)
