(define (problem viaje-ext4-3)
    (:domain agencia-viajes-ext4)

    (:objects
        madrid roma florencia zaragoza murcia oporto lisboa - ciudad
        h-madrid h-roma h-flo h-zar h-mur h-opo h-lis - hotel
    )

    (:init
        (viaje-por-empezar)
        (en-ciudad h-madrid madrid)
        (en-ciudad h-roma roma) (en-ciudad h-flo florencia)
        (en-ciudad h-zar zaragoza) (en-ciudad h-mur murcia)
        (en-ciudad h-opo oporto) (en-ciudad h-lis lisboa)

        ;; RUTA VIP (Mucho interés, pero muy cara)
        (conectada madrid roma)
        (conectada roma florencia)

        ;; RUTA LOW-COST (Económica, pero no aporta interés cultural)
        (conectada madrid zaragoza)
        (conectada zaragoza murcia)

        ;; RUTA EQUILIBRADA (Precios moderados, interés intermedio)
        (conectada madrid oporto)
        (conectada oporto lisboa)

        (= (ciudades-visitadas) 0) (= (dias-totales) 0)
        (= (presupuesto-gastado) 0) (= (interes-total) 0)
        (= (dias-en madrid) 0) (= (dias-en roma) 0) (= (dias-en florencia) 0)
        (= (dias-en zaragoza) 0) (= (dias-en murcia) 0)
        (= (dias-en oporto) 0) (= (dias-en lisboa) 0)

        ;; TIEMPOS
        (= (min-dias madrid) 1) (= (max-dias madrid) 2)
        (= (min-dias roma) 1) (= (max-dias roma) 2)
        (= (min-dias florencia) 1) (= (max-dias florencia) 2)
        (= (min-dias zaragoza) 1) (= (max-dias zaragoza) 2)
        (= (min-dias murcia) 1) (= (max-dias murcia) 2)
        (= (min-dias oporto) 1) (= (max-dias oporto) 2)
        (= (min-dias lisboa) 1) (= (max-dias lisboa) 2)

        ;; ASIGNACIÓN DE INTERÉS (1 es alto, 2 es medio, 3 es bajo)
        (= (interes madrid) 2)
        (= (interes roma) 1)
        (= (interes florencia) 1)
        (= (interes zaragoza) 3)
        (= (interes murcia) 3)
        (= (interes oporto) 2)
        (= (interes lisboa) 2)

        ;; PRECIOS RUTA VIP (Total estimado corregido: 650€)
        (= (precio-hotel h-madrid) 50)
        (= (precio-hotel h-roma) 200)
        (= (precio-hotel h-flo) 200)
        (= (precio-vuelo madrid roma) 100)
        (= (precio-vuelo roma florencia) 100)

        ;; PRECIOS RUTA LOW-COST (Total estimado corregido: 150€)
        (= (precio-hotel h-zar) 30)
        (= (precio-hotel h-mur) 30)
        (= (precio-vuelo madrid zaragoza) 20)
        (= (precio-vuelo zaragoza murcia) 20)

        ;; PRECIOS RUTA EQUILIBRADA (Total estimado corregido: 310€)
        (= (precio-hotel h-opo) 70)
        (= (precio-hotel h-lis) 70)
        (= (precio-vuelo madrid oporto) 60)
        (= (precio-vuelo oporto lisboa) 60)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)
        (>= (dias-totales) 3)

        ;; 1. Se exige calidad: El interés total debe ser bueno (<= 6)
        ;; Descarta automáticamente la ruta Low-Cost (Zaragoza/Murcia sumaría 2+3+3 = 8)
        (<= (interes-total) 6)

        ;; 2. Se exige control del gasto: El presupuesto no puede pasar de 500€
        ;; Descarta automáticamente la ruta VIP (Roma/Florencia cuesta 650€ con el modelo corregido)
        (<= (presupuesto-gastado) 500)
    ))

    ;; Se optimiza de forma equilibrada
    (:metric minimize (+ (* 10 (interes-total)) (* 1 (presupuesto-gastado))))
)
