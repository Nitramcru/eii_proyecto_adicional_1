# Proyecto Adicional 1 - Sencillo microcontrolador RISC-V

Electrónica II para Ingeniería Electrónica. 2024

## Objetivos

- Modificar el núcleo del proyecto 10 para implementar las instrucciones lui y auipc
- Definir espacio de direcciones, mapa de memoria y bus de computadora
- Integrar en un microcontrolador el núcleo desarrollado en el proyecto 10 con un bus incluyendo además de la memoria de programa y datos, cuatro puertos de entrada y cuatro puertos de salida.
  - Utilizar para memoria las direcciones 0x00000000 a 0x7FFFFFFF
  - Utilizar para IO las direcciones 0x80000000 a 0xFFFFFFFF
- Realizar la síntesis lógica y configurar una placa EDU-CIAA-FPGA con el microcontrolador desarrollado.

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
