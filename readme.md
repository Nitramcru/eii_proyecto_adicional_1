# Proyecto Adicional 1 - Sencillo microcontrolador RISC-V

Electrónica II para Ingeniería Electrónica. 2024

## Objetivos

- Modificar el núcleo del proyecto 10 para implementar las instrucciones lui y auipc
- Definir espacio de direcciones, mapa de memoria y bus de computadora
- Integrar en un microcontrolador el núcleo desarrollado en el proyecto 10 con un bus incluyendo además de la memoria de programa y datos, cuatro puertos de entrada y cuatro puertos de salida.
  - Utilizar para memoria las direcciones 0x00000000 a 0x7FFFFFFF
  - Utilizar para IO las direcciones 0x80000000 a 0xFFFFFFFF
  - Cada pin de entrada o salida se representa por un registro de 32 bit con alineación de palabra (el bus del proyecto 10 no permite acceso a byte ni media palabra). Un valor de 1 corresponderá al estado ALTO y un 0 al estado BAJO del pin.
  - En los pines de entrada se utilizará un sincronizador de dos flip-flop.
- Realizar la síntesis lógica y configurar una placa EDU-CIAA-FPGA con el microcontrolador desarrollado. Para ello deberás instalar OSS CAD Suite de YosysHQ

## Entregables

Repositorio git con la descripción de hardware desarrollada.
Un informe que presente lo siguiente:

Un informe con la siguiente estructura:

- *Título*
- *Autor*
- *Resumen*
- *Introducción* Presentar los conceptos de bus de computadora, espacio de direcciones y mapa de memoria. Presentar los objetivos del proyecto.
- *Desarrollo* Presentar el mapa de memoria desarrollado y un detalle de los registros de control de entrada/salida.
- *Resultados* Explicar los cambios realizados sobre el proyecto 10, el diseño del bus de computadora y el microcontrolador. Presentar los resultados de simulación y pruebas sobre hardware.
- *Conclusiones* Concluir, en base a los resultados obtenidos, sobre el cumplimiento de los objetivos.
- *Referencias*

## Programas de prueba:

### Parpadeo con retardo (para ejecutar en placa)

Código C

~~~C
#include <stdint.h>
int main(void)
{
    volatile uint32_t *const o0 = (void*)0x80000010;
    *o0 = 0;
    for(;;)
    {
        *o0 = ! *o0;
        for(int i=0;i<(12000000-8)/9;++i) ;
    }
}
~~~

Listado ensamblador

~~~asm
00000000 <main>:
    0:         80000737        lui x14 0x80000
    4:         001466b7        lui x13 0x146
    8:         00000793        addi x15 x0 0
    c:         00c0006f        jal x0 12 <L2>
00000010 <L3>:
    10:        01072783        lw x15 16 x14
    14:        0017b793        sltiu x15 x15 1
00000018 <L2>:
    18:        00f72823        sw x15 16 x14
    1c:        85468793        addi x15 x13 -1964
00000020 <L1>:
    20:        fff78793        addi x15 x15 -1
    24:        fe079ee3        bne x15 x0 -4 <L1>
    28:        fe9ff06f        jal x0 -24 <L3>
~~~

Archivo parpadeo_con_retardo.mem:

~~~hex
80000737
001466b7
00000793
00c0006f
01072783
0017b793
00f72823
85468793
fff78793
fe079ee3
fe9ff06f
~~~

### Parpadeo sin retardo (para ejecutar en simulador)

Código C

~~~C
#include <stdint.h>
int main(void)
{
    volatile uint32_t *const o0 = (void*)0x80000010;
    *o0 = 0;
    for(;;)
    {
        *o0 = ! *o0;
    }
}
~~~

Listado Ensamblador

~~~asm
00000000 <main>:
    0:         80000737        lui x14 0x80000
    4:         00000793        addi x15 x0 0
    8:         00c0006f        jal x0 12 <L1>
0000000c <L2>:
    c:         01072783        lw x15 16 x14
    10:        0017b793        sltiu x15 x15 1
00000014 <L1>:
    14:        00f72823        sw x15 16 x14
    18:        ff5ff06f        jal x0 -12 <L2>
~~~

Archivo parpadeo_sin_retardo.mem:

~~~hex
80000737
00000793
00c0006f
01072783
0017b793
00f72823
ff5ff06f
~~~