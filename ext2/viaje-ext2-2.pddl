(define (problem viaje-ext2-2)
    (:domain agencia-viajes-ext2)

    (:objects
        ;; Zona 1: España (Ruta corta pero aburrida)
        madrid zaragoza barcelona - ciudad
        hotel-m hotel-z hotel-b - hotel

        ;; Zona 2: Italia (Ruta larga pero de máximo interés)
        roma florencia venecia milan - ciudad
        hotel-r hotel-f hotel-v hotel-mi - hotel
    )

    (:init
        (viaje-por-empezar)

        ;; Asignación de hoteles
        (en-ciudad hotel-m madrid)
        (en-ciudad hotel-z zaragoza)
        (en-ciudad hotel-b barcelona)
        (en-ciudad hotel-r roma)
        (en-ciudad hotel-f florencia)
        (en-ciudad hotel-v venecia)
        (en-ciudad hotel-mi milan)

        ;; CONEXIONES DEL GRAFO
        ;; Ruta España
        (conectada madrid zaragoza) (conectada zaragoza madrid)
        (conectada zaragoza barcelona) (conectada barcelona zaragoza)

        ;; Ruta Italia
        (conectada roma florencia) (conectada florencia roma)
        (conectada florencia venecia) (conectada venecia florencia)
        (conectada venecia milan) (conectada milan venecia)

        ;; Conexión mínima para que sea un solo grafo (según el guión)
        (conectada barcelona roma) (conectada roma barcelona)

        ;; Inicialización de contadores
        (= (ciudades-visitadas) 0)
        (= (dias-totales) 0)
        (= (interes-total) 0)

        (= (dias-en madrid) 0) (= (dias-en zaragoza) 0) (= (dias-en barcelona) 0)
        (= (dias-en roma) 0) (= (dias-en florencia) 0) (= (dias-en venecia) 0) (= (dias-en milan) 0)

        ;; TIEMPOS E INTERESES

        ;; ZONA ESPAÑA: Permite estar muchos días.
        ;; Se pueden conseguir 6 días visitando solo 3 ciudades.
        (= (min-dias madrid) 1) (= (max-dias madrid) 4)
        (= (min-dias zaragoza) 1) (= (max-dias zaragoza) 4)
        (= (min-dias barcelona) 1) (= (max-dias barcelona) 4)

        ;; Interés malo (Valor 3 = aburrido)
        (= (interes madrid) 3)
        (= (interes zaragoza) 3)
        (= (interes barcelona) 3)

        ;; ZONA ITALIA: Restricciones de tiempo muy estrictas.
        ;; Para conseguir 6 días, es OBLIGATORIO visitar las 4 ciudades
        (= (min-dias roma) 1) (= (max-dias roma) 2)
        (= (min-dias florencia) 1) (= (max-dias florencia) 1)
        (= (min-dias venecia) 1) (= (max-dias venecia) 1)
        (= (min-dias milan) 1) (= (max-dias milan) 2)

        ;; Interés excelente (Valor 1 = máximo interés)
        (= (interes roma) 1)
        (= (interes florencia) 1)
        (= (interes venecia) 1)
        (= (interes milan) 1)
    )

    (:goal (and
        (viaje-finalizado)
        (>= (ciudades-visitadas) 3)  ;; Mínimo 3 ciudades
        (>= (dias-totales) 6)        ;; Mínimo 6 días de viaje
    ))

    ;; Optimizamos para buscar el menor valor posible
    (:metric minimize (interes-total))
)
