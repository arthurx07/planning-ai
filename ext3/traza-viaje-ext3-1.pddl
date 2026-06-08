
ff: parsing domain file
domain 'AGENCIA-VIAJES-EXT3' defined
 ... done.
ff: parsing problem file
problem 'VIAJE-EXT3-1' defined
 ... done.


metric established (normalized to minimize): ((1.00*[RF4](PRESUPUESTO-GASTADO)) - () + 0.00)

checking for cyclic := effects --- OK.

ff: search configuration is  best-first on 1*g(s) + 5*h(s) where
    metric is ((1.00*[RF4](PRESUPUESTO-GASTADO)) - () + 0.00)

advancing to distance:   14
                         12
                         11
                         10
                          8
                          6
                          5
                          4
                          3
                          2
                          1
                          0

ff: found legal plan as follows

step    0: EMPEZAR-VIAJE MADRID
        1: RESERVAR-HOTEL HOTEL-M MADRID
        2: PASAR-DIA MADRID HOTEL-M
        3: PASAR-DIA MADRID HOTEL-M
        4: VOLAR MADRID ROMA
        5: RESERVAR-HOTEL HOTEL-R ROMA
        6: PASAR-DIA ROMA HOTEL-R
        7: PASAR-DIA ROMA HOTEL-R
        8: VOLAR ROMA PARIS
        9: RESERVAR-HOTEL HOTEL-P PARIS
       10: PASAR-DIA PARIS HOTEL-P
       11: TERMINAR-VIAJE PARIS
     

time spent:    0.00 seconds instantiating 24 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 23 facts and 24 actions
               0.00 seconds creating final representation with 23 relevant facts, 12 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 30 states, to a max depth of 0
               0.00 seconds total time

