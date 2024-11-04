#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

ESP8266WebServer server(80);

void setup() {
  Serial.begin(9600);

  WiFi.softAP("ROBOCORN", "lok25453");

  Serial.println("Access Point Created");
  Serial.print("IP Address: ");
  Serial.println(WiFi.softAPIP());

  server.on("/command", handleCommand);

  server.begin();
}

void loop() {
  server.handleClient();
}

void handleCommand() {
  if (server.hasArg("value")) {
    int command = server.arg("value").toInt();
    Serial.println(command);
  }
  server.send(200, "text/plain", "OK");
}
