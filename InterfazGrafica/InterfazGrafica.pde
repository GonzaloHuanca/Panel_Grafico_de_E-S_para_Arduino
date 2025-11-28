import processing.serial.*;

Serial puerto;

// Variables de estado
int p1 = 0, p2 = 0;
int l1 = 0, l2 = 0;

// Coordenadas de componentes
PVector posE1 = new PVector(240, 70);
PVector posE2 = new PVector(330, 70);

PVector posL1 = new PVector(260, 170);
PVector posL2 = new PVector(350, 170);



void setup() {
  size(600, 300);
  
  // Abrir puerto
  puerto = new Serial(this, Serial.list()[0], 9600);
  puerto.bufferUntil('\n');
}


void draw() {
  background(240);

  dibujarTitulo();
  dibujarPanelEntradas();
  dibujarPanelSalidas();

}



// DIBUJO — UI


void dibujarTitulo() {
  fill(30);
  textSize(22);
  text("INTERFAZ DE CONTROL DE E/S ARDUINO", 100, 30);
}


void dibujarPanelEntradas() {
  // Panel
  fill(200,220,255);
  rect(60,60,120,40,7);
  fill(0);
  text("Entradas", 80,90);

  // Controles
  dibujarEntrada(p1, posE1, "E1");
  dibujarEntrada(p2, posE2, "E2");
}


void dibujarPanelSalidas() {
  // Panel
  fill(255,220,200);
  rect(60,150,120,40,7);
  fill(0);
  text("Salidas", 80,180);

  // Controles
  dibujarSalida(l1, posL1, "L1");
  dibujarSalida(l2, posL2, "L2");
}

// COMPONENTES GRAFICOS 

void dibujarEntrada(int estado, PVector pos, String etiqueta) {
  stroke(0);
  fill(estado == 1 ? color(0,180,0) : color(230));
  rect(pos.x, pos.y, 50, 40, 5);
  fill(0);
  text(etiqueta, pos.x + 15, pos.y + 25);
}

void dibujarSalida(int brillo, PVector pos, String etiqueta) {
  stroke(0);

  // brillo controla la intensidad del LED (0–255)
  fill(color(brillo, 80, 0));

  ellipse(pos.x, pos.y, 60, 60);

  fill(0);
  text(etiqueta, pos.x - 10, pos.y + 7);
}

// INTERACCIÓN — CLIC DEL MOUSE

void mousePressed() {

  if (clicEnLed(posL1)) {
    l1 = (l1 > 0) ? 0 : 255;
    enviarComando("L1=" + l1);
  }

  if (clicEnLed(posL2)) {
    l2 = (l2 > 0) ? 0 : 255;
    enviarComando("L2=" + l2);
  }
}

boolean clicEnLed(PVector pos) {
  return dist(mouseX, mouseY, pos.x, pos.y) < 30;
}

// SERIAL — RECEPCIÓN DE DATOS

void serialEvent(Serial p) {
  String linea = p.readStringUntil('\n');
  if (linea == null) return;

  procesarLinea(trim(linea));
}

void procesarLinea(String linea) {
  if (!linea.startsWith("E")) return;

  String[] v = split(linea, ',');

  if (v.length == 5) {
    p1 = int(v[1]);
    p2 = int(v[2]);
    l1 = int(v[3]);
    l2 = int(v[4]);
  }
}

// SERIAL — ENVÍO DE COMANDOS

void enviarComando(String cmd) {
  puerto.write(cmd + "\n");
}
