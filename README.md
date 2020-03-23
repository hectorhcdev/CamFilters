# CamFilters

## Autor

Héctor Henríquez Cabrera

Correo: [hector.henriquez101@alu.ulpgc.es](mailto:hector.henriquez101@alu.ulpgc.es)

Asignatura: Creando Interfaces de Usuario (CIU)

## Introducción

En está sexta práctica se ha compuesto una aplicación mediante **processing 3**. Se ha creado una ventana que con la ayuda de una cámara web se podrá observar dos filtros, uno modifica la imagen completamente para asemejarse a una viñeta de un dibujo y la que pondrá un casco.

## Demo

![img](demo.gif)

En la demo se puede apreciar tanto la imagen sin sufrir ningún cambio como la imagen con el filtro activado. Además se puede observar los diferentes filtros implementados.

## Implementación

### Librerías

Para la implementación de esta aplicación se ha usado **GifAnimation**. Pero esta no es necesario para su reproducción en otro sistema ya que  solo se uso para  la inclusión del gif, que serviría de demo, pero a  la hora de probar la aplicación no es necesario tenerlo instalado, debido a que no ejecuta nada actualmente (en caso de querer generar un gif nuevo descomentar las líneas de esta librería) .

Además se ha usado las librerías de **opencv4** mencionada en el guion de prácticas para la implementación de los dos filtros.

### Diseño

Para el diseño de esta aplicación se opto por añadir la menor cantidad  de elementos que dificultasen la visualización del sistema, solo teniendo texto mostrando los filtros y el filtro actual.

### Funcionalidades

Las funcionalidades básicas añadidas en esta práctica han sido la implementación de los dos filtros, el primero se realizó mediante opencv4. La segunda se trata de reconocer la caras en la imagen y ponerles un casco de astronauta, dicha funcionalidad también se implementó con opencv4.

## Controles

Todas las interrupciones manejadas en este programa han sido mediante teclado, por lo que se han manejado las interrupciones generadas mediante la función **keyPressed**. Las teclas y acciones consecuentes que las activan son:

| Tecla | Uso                      |
| ----- | ------------------------ |
| 1     | Cambiar a filtro dibujo  |
| 2     | Cambiar a filtro máscara |

## Bibliografía

[Guion de prácticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/22/CIU_Pr_cticas.pdf)

[processing.org](https://processing.org/)

[Imagen máscara](https://www.pngocean.com/gratis-png-clipart-dbicm/descargar)