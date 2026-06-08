# Planificación - Recomendador de Viajes

Práctica de **Planificación**.

El programa, dado un problema escrito en PDDL, recomienda un plan de viaje
adaptado a los requisitos del problema.

## Estructura del proyecto
Este proyecto contiene cinco directorios, cada uno implementando su correspondiente
nivel, como indica su nombre.

Dentro de cada directorio se incluye el dominio del problema escrito en `pddl`
(`domain-nivel.pddl`) y varios juegos de prueba (`viaje-nivel-x.pddl`) para
probar cada nivel.  
Además, se incluyen las trazas de salida de ejecutar el dominio con el juego
de prueba correspondiente como problema (`traza-viaje-nivel-x.txt`).

```
.
├── basico
│   ├── domain-basico.pddl
│   ├── traza-viaje-basico-1.txt
│   ├── traza-viaje-basico-2.txt
│   ├── viaje-basico-1.pddl
│   └── viaje-basico-2.pddl
├── ext1
│   ├── domain-ext1.pddl
│   ├── traza-viaje-ext1-1.txt
│   ├── traza-viaje-ext1-2.txt
│   ├── traza-viaje-ext1-3.txt
│   ├── viaje-ext1-1.pddl
│   ├── viaje-ext1-2.pddl
│   └── viaje-ext1-3.pddl
├── ext2
│   ├── domain-ext2.pddl
│   ├── traza-viaje-ext2-1.txt
│   ├── traza-viaje-ext2-2.txt
│   ├── viaje-ext2-1.pddl
│   └── viaje-ext2-2.pddl
├── ext3
│   ├── domain-ext3.pddl
│   ├── traza-viaje-ext3-1.pddl
│   ├── traza-viaje-ext3-2.pddl
│   ├── traza-viaje-ext3-3.pddl
│   ├── traza-viaje-ext3-4.pddl
│   ├── viaje-ext3-1.pddl
│   ├── viaje-ext3-2.pddl
│   ├── viaje-ext3-3.pddl
│   └── viaje-ext3-4.pddl
└── ext4
    ├── domain-ext4.pddl
    ├── traza-viaje-ext4-1.txt
    ├── traza-viaje-ext4-2.txt
    ├── traza-viaje-ext4-3.txt
    ├── viaje-ext4-1.pddl
    ├── viaje-ext4-2.pddl
    └── viaje-ext4-3.pddl
```

## Ejecución

Para ejecutar estos programas se necesita tener `MetricFF` instalado.

Para `básico` y `ext1` se debería usar el comando:

```
ff -o domain-vers.pddl -f viaje-vers-num.pddl
```

En cambio, para `ext2`, `ext3` y `ext4` se debería usar el comando:

```
ff -O -o domain-vers.pddl -f viaje-vers-num.pddl
```
