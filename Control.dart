import 'package:flutter_application_1/main.dart';



void sendCommand(int command) {
  if (connection != null && connection!.isConnected) {
    connection!.output.add(utf8.encode('$command\n'));

  }
}