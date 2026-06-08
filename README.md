# planning-ai

Para ejecutar estos archivos se necesita tener MetricFF instalado.

Para `básico` y `ext1` se debería usar el comando:

```
ff -o domain-vers.pddl -f viaje-vers-num.pddl
```

En cambio, para `ext2`, `ext3` y `ext4` se debería usar el comando:

```
ff -O -o domain-vers.pddl -f viaje-vers-num.pddl
```

## Cambios aplicados antes de la entrega

Se han aplicado mejoras de consistencia al modelo final:

- En `ext3` y `ext4`, la acción `reservar-hotel` ya no incrementa el presupuesto. El coste del hotel se paga únicamente por noche en `pasar-dia`, que es el modelado más natural.
- Se han ajustado los límites de presupuesto de los problemas afectados por ese cambio.
- En los problemas de `ext4`, se ha añadido explícitamente la restricción `(>= (dias-totales) 3)` para que la extensión final herede claramente la restricción temporal de la Extensión 1.
- Se ha reemplazado la ciudad llamada `origen` por `madrid` en los problemas donde podía confundirse con la ciudad real de origen del cliente.
- En los problemas dirigidos de ramas alternativas, se han dejado solo las conexiones necesarias para evitar vuelos inversos con precios no deseados y para que el planificador elija una ruta completa coherente.
- Las trazas antiguas de `ext3` y `ext4`, que ya no correspondían exactamente al modelo corregido, se han sustituido por trazas de validación por simulación y por el fichero `VALIDACION_MODELO.txt`.

Para generar las trazas oficiales con Metric-FF, ejecutar por ejemplo:

```bash
ff -o ext4/domain-ext4.pddl -f ext4/viaje-ext4-1.pddl > ext4/traza-viaje-ext4-1.txt
```

Repetir el comando para cada problema de prueba.
