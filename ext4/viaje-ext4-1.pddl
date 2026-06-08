(define (problem viaje-ext4-1-barato)
    (:domain agencia-viajes-ext4)

    (:objects
        origen roma florencia zaragoza murcia - ciudad
        h-origen h-roma h-flo h-zar h-mur - hotel
    )

    (:init
        (viaje-por-empezar)
        (en-ciudad h-origen origen)
        (en-ciudad h-roma roma) (en-ciudad h-flo florencia)
        (en-ciudad h-zar zaragoza) (en-ciudad h-mur murcia)

        ;; RUTA VIP
        (conectada origen roma) (conectada roma origen)
        (conectada roma florencia) (conectada florencia roma)
        
        ;; RUTA LOW-COST
        (conectada origen zaragoza) (conectada zaragoza origen)
        (conectada zaragoza murcia) (conectada murcia zaragoza)

        (= (ciudades-visitadas) 0) (= (dias-totales) 0)
        (= (presupuesto-gastado) 0) (= (interes-total) 0)
        (= (dias-en origen) 0) (= (dias-en roma) 0) (= (dias-en florencia) 0)
        (= (dias-en zaragoza) 0) (= (dias-en murcia) 0)

        ;; TIEMPOS
        (= (min-dias origen) 1) (= (max-dias origen) 2)
        (= (min-dias roma) 1) (= (max-dias roma) 2)
        (= (min-dias florencia) 1) (= (max-dias florencia) 2)
        (= (min-dias zaragoza) 1) (= (max-dias zaragoza) 2)
        (= (min-dias murcia) 1) (= (max-dias murcia) 2)

        ;; INTERÉS
        (= (interes origen) 2)
        (= (interes roma) 1)      ;; Muy interesante
        (= (interes florencia) 1) ;; Muy interesante
        (= (interes zaragoza) 3)  ;; Poco interesante
        (= (interes murcia) 3)    ;; Poco interesante

        ;; PRECIOS VIP (Caros)
        (= (precio-hotel h-origen) 50)
        (= (precio-hotel h-roma) 200)
        (= (precio-hotel h-flo) 200)
        (= (precio-vuelo origen roma) 100)
        (= (precio-vuelo roma florencia) 100)

        ;; PRECIOS LOW-COST (Baratos)
        (= (precio-hotel h-zar) 30)
        (= (precio-hotel h-mur) 30)
        (= (precio-vuelo origen zaragoza) 20)
        (= (precio-vuelo zaragoza murcia) 20)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)
    ))

    ;; PONDERACIÓN: 
    ;; Multiplicamos el interés por 1, y el presupuesto por 1.
    ;; Resultado: El presupuesto ahoga al interés. El planificador elegirá Low-Cost.
    (:metric minimize (+ (* 1 (interes-total)) (* 1 (presupuesto-gastado))))
)