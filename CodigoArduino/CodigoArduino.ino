// Pines
const int P1 = 2;
const int P2 = 3;
const int L1 = 9;
const int L2 = 10;

int e1 = 0, e2 = 0;// Entradas-Pulsadores
int l1 = 0, l2 = 0;// Salidas-Leds

String buffer = "";

// Temporizador envío
unsigned long tiempoPrevio = 0;
const unsigned long intervaloEnvio = 60;

// Leer pulsadores
void leerEntradas() {
  e1 = !digitalRead(P1);
  e2 = !digitalRead(P2);
}

void actualizarSalidas() {
  analogWrite(L1, l1);
  analogWrite(L2, l2);
}

void aplicarLogicaLocal() {
  l1 = e1 * 255;
  l2 = e2 * 255;
}

// Enviar datos a processing
void enviarEstado() {
  Serial.print("E,");
  Serial.print(e1); Serial.print(",");
  Serial.print(e2); Serial.print(",");
  Serial.print(l1); Serial.print(",");
  Serial.println(l2);
}

// Procesar comandos de processing
void procesarComando(String cmd) {
  if (cmd.startsWith("L1=")) {
    l1 = cmd.substring(3).toInt();
  }
  else if (cmd.startsWith("L2=")) {
    l2 = cmd.substring(3).toInt();
  }
  actualizarSalidas();
}

// Recibe datos
void recibirComandos() {
  while (Serial.available()) {
    char c = Serial.read();

    if (c == '\n') {
      procesarComando(buffer);
      buffer = "";
    } else {
      buffer += c;
    }
  }
}


void setup() {
  Serial.begin(9600);

  pinMode(P1, INPUT_PULLUP);
  pinMode(P2, INPUT_PULLUP);

  pinMode(L1, OUTPUT);
  pinMode(L2, OUTPUT);
}

void loop() {

  leerEntradas();
  aplicarLogicaLocal();
  actualizarSalidas();
  recibirComandos();

  // Enviar estados cada 60 ms
  if (millis() - tiempoPrevio >= intervaloEnvio) {
    tiempoPrevio = millis();
    enviarEstado();
  }
}
