#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

const char* ssid_sta = "wifi"; 
const char* password_sta = "pass"; 

const char* ssid_ap = "namewifi";
const char* password_ap = "pass";

ESP8266WebServer server(80);

void setup() {
  Serial.begin(9600);

  WiFi.begin(ssid_sta, password_sta);
  Serial.print("Menghubungkan ke WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nTerhubung ke WiFi!");
  Serial.print("IP Address STA: ");
  Serial.println(WiFi.localIP());

  WiFi.softAP(ssid_ap, password_ap);
  Serial.println("Access Point Created");
  Serial.print("IP Address AP: ");
  Serial.println(WiFi.softAPIP());

  server.on("/command", handleCommand);
  server.begin();
  Serial.println("Web Server is Running");
}

void loop() {
  server.handleClient();
}

void handleCommand() {
  if (server.hasArg("value")) {
    int command = server.arg("value").toInt();
    Serial.print("Command Received: ");
    Serial.println(command);
  }
  server.send(200, "text/plain", "Command Received");
}

