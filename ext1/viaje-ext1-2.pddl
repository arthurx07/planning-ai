(define (problem viaje-ext1-2)
    (:domain agencia-viajes-ext1)

    (:objects
        madrid barcelona lyon paris roma - ciudad
        hotel-m hotel-b hotel-l hotel-p hotel-r - hotel
    )

    (:init
        (viaje-por-empezar)

        ;; Asignación de hoteles
        (en-ciudad hotel-m madrid)
        (en-ciudad hotel-b barcelona)
        (en-ciudad hotel-l lyon)
        (en-ciudad hotel-p paris)
        (en-ciudad hotel-r roma)

        ;; Grafo con cuello de botella (Lyon es paso obligatorio hacia Europa)
        (conectada madrid barcelona)
        (conectada barcelona madrid)

        (conectada barcelona lyon)
        (conectada lyon barcelona)

        (conectada lyon paris)
        (conectada paris lyon)

        (conectada lyon roma)
        (conectada roma lyon)

        ;; Inicialización de contadores globales
        (= (ciudades-visitadas) 0)
        (= (dias-totales) 0)

        ;; Inicialización de días en cada ciudad
        (= (dias-en madrid) 0)
        (= (dias-en barcelona) 0)
        (= (dias-en lyon) 0)
        (= (dias-en paris) 0)
        (= (dias-en roma) 0)

        ;; RESTRICCIONES DE TIEMPO (El truco de este problema)
        ;; Ciudades normales: mínimo 2 días, máximo 4
        (= (min-dias madrid) 2)
        (= (max-dias madrid) 4)

        (= (min-dias barcelona) 2)
        (= (max-dias barcelona) 4)

        (= (min-dias paris) 2)
        (= (max-dias paris) 4)

        (= (min-dias roma) 2)
        (= (max-dias roma) 4)

        ;; CUELLO DE BOTELLA TEMPORAL: En Lyon solo se puede estar 1 día
        (= (min-dias lyon) 1)
        (= (max-dias lyon) 1)
    )

    (:goal (and
        (viaje-finalizado)
        ;; Exigimos visitar al menos 4 ciudades (ej: Madrid -> Bcn -> Lyon -> Paris)
        (>= (ciudades-visitadas) 4)

        ;; Exigimos que el viaje dure al menos 10 días totales.
        ;; Como en Lyon solo pueden estar 1 día, tendrán que pasar 9 días
        ;; repartidos entre las otras 3 ciudades visitadas.
        (>= (dias-totales) 10)
    ))
)
