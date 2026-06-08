(define (problem viaje-basico-2)
    (:domain agencia-viajes)

    ;; ==========================================
    ;; OBJETOS: Añadimos Lyon y su respectivo hotel
    ;; ==========================================
    (:objects
        madrid barcelona lyon paris roma - ciudad
        hotel-m hotel-b hotel-l hotel-p hotel-r - hotel
    )

    ;; ==========================================
    ;; ESTADO INICIAL: Rediseño del grafo de vuelos
    ;; ==========================================
    (:init
        (viaje-por-empezar)

        ;; 1. Asignación de hoteles a ciudades
        (en-ciudad hotel-m madrid)
        (en-ciudad hotel-b barcelona)
        (en-ciudad hotel-l lyon)       ; Nuevo hotel en Lyon
        (en-ciudad hotel-p paris)
        (en-ciudad hotel-r roma)

        ;; 2. Conexiones (Grafo con cuello de botella)
        ;; Solo se puede salir de España pasando por Lyon
        (conectada madrid barcelona)
        (conectada barcelona madrid)

        (conectada barcelona lyon)
        (conectada lyon barcelona)

        ;; Desde Lyon se bifurca el camino hacia París o Roma
        (conectada lyon paris)
        (conectada paris lyon)

        (conectada lyon roma)
        (conectada roma lyon)

        ;; 3. Inicialización de contadores
        (= (ciudades-visitadas) 0)
        (= (hoteles-reservados) 0)
    )

    ;; ==========================================
    ;; OBJETIVO: Mayor exigencia
    ;; ==========================================
    (:goal (and
        ;; Aumentamos la dificultad: ahora el turista debe visitar al menos 4 ciudades
        (>= (ciudades-visitadas) 4)
        
        ;; Mantenemos nuestra regla matemática optimizada para asegurar alojamientos
        (= (ciudades-visitadas) (hoteles-reservados))
    ))
)