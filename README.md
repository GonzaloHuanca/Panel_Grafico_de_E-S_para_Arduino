# Panel_Grafico_de_E-S_para_Arduino

### Introducción
Este proyecto combina las capacidades de Arduino para manejar entradas y salidas digitales con el potencial gráfico de Processing. La integración permite construir una interfaz visual interactiva que refleja en pantalla el estado de los pulsadores y LEDs conectados al Arduino, mientras que el usuario también puede enviar acciones desde la computadora hacia la placa.  
El objetivo es brindar una herramienta sencilla pero completa para experimentar con comunicación serial, lectura de sensores, control de actuadores y diseño de interfaces.

### Descripción
El sistema está compuesto por dos programas: uno ejecutado en Arduino y otro en Processing.  
Arduino se encarga de leer el estado de los pulsadores, controlar los LEDs y enviar periódicamente su estado a través del puerto serial. Processing recibe esta información y la representa gráficamente, mostrando cada entrada y salida mediante indicadores visuales.  
Además, el usuario puede interactuar con la interfaz haciendo clic sobre los elementos representados en pantalla; dichos eventos son enviados al Arduino para modificar sus salidas en tiempo real.  
El proyecto sirve como base para desarrollar paneles de control, tableros de monitoreo o interfaces didácticas para comprender la comunicación entre hardware y software.
