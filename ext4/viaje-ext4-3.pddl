(define (problem viaje-ext4-3)
    (:domain agencia-viajes-ext4)

    (:objects
        origen roma florencia zaragoza murcia oporto lisboa - ciudad
        h-origen h-roma h-flo h-zar h-mur h-opo h-lis - hotel
    )

    (:init
        (viaje-por-empezar)
        (en-ciudad h-origen origen)
        (en-ciudad h-roma roma) (en-ciudad h-flo florencia)
        (en-ciudad h-zar zaragoza) (en-ciudad h-mur murcia)
        (en-ciudad h-opo oporto) (en-ciudad h-lis lisboa)

        ;; RUTA VIP (Mucho interés, pero muy cara)
        (conectada origen roma) (conectada roma origen)
        (conectada roma florencia) (conectada florencia roma)

        ;; RUTA LOW-COST (Económica, pero no aporta interés cultural)
        (conectada origen zaragoza) (conectada zaragoza origen)
        (conectada zaragoza murcia) (conectada murcia zaragoza)

        ;; RUTA EQUILIBRADA (Precios moderados, interés intermedio)
        (conectada origen oporto) (conectada oporto origen)
        (conectada oporto lisboa) (conectada lisboa oporto)

        (= (ciudades-visitadas) 0) (= (dias-totales) 0)
        (= (presupuesto-gastado) 0) (= (interes-total) 0)
        (= (dias-en origen) 0) (= (dias-en roma) 0) (= (dias-en florencia) 0)
        (= (dias-en zaragoza) 0) (= (dias-en murcia) 0)
        (= (dias-en oporto) 0) (= (dias-en lisboa) 0)

        ;; TIEMPOS
        (= (min-dias origen) 1) (= (max-dias origen) 2)
        (= (min-dias roma) 1) (= (max-dias roma) 2)
        (= (min-dias florencia) 1) (= (max-dias florencia) 2)
        (= (min-dias zaragoza) 1) (= (max-dias zaragoza) 2)
        (= (min-dias murcia) 1) (= (max-dias murcia) 2)
        (= (min-dias oporto) 1) (= (max-dias oporto) 2)
        (= (min-dias lisboa) 1) (= (max-dias lisboa) 2)

        ;; ASIGNACIÓN DE INTERÉS (1 es alto, 2 es medio, 3 es bajo)
        (= (interes origen) 2)
        (= (interes roma) 1)
        (= (interes florencia) 1)
        (= (interes zaragoza) 3)
        (= (interes murcia) 3)
        (= (interes oporto) 2)
        (= (interes lisboa) 2)

        ;; PRECIOS RUTA VIP (Total estimado: ~1100€)
        (= (precio-hotel h-origen) 50)
        (= (precio-hotel h-roma) 200)
        (= (precio-hotel h-flo) 200)
        (= (precio-vuelo origen roma) 100)
        (= (precio-vuelo roma florencia) 100)

        ;; PRECIOS RUTA LOW-COST (Total estimado: ~260€)
        (= (precio-hotel h-zar) 30)
        (= (precio-hotel h-mur) 30)
        (= (precio-vuelo origen zaragoza) 20)
        (= (precio-vuelo zaragoza murcia) 20)

        ;; PRECIOS RUTA HÍBRIDA (Total estimado: ~500€)
        (= (precio-hotel h-opo) 70)
        (= (precio-hotel h-lis) 70)
        (= (precio-vuelo origen oporto) 60)
        (= (precio-vuelo oporto lisboa) 60)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)

        ;; 1. Se exige calidad: El interés total debe ser bueno (<= 6)
        ;; Descarta automáticamente la ruta Low-Cost (Zaragoza/Murcia sumaría 2+3+3 = 8)
        (<= (interes-total) 6)

        ;; 2. Se exige control del gasto: El presupuesto no puede pasar de 700€
        ;; Descarta automáticamente la ruta VIP (Roma/Florencia cuesta ~1100€)
        (<= (presupuesto-gastado) 700)
    ))

    ;; Se optimiza de forma equilibrada
    (:metric minimize (+ (* 10 (interes-total)) (* 1 (presupuesto-gastado))))
)
