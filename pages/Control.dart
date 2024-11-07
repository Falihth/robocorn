import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class DpadControl extends StatelessWidget {
  final String serverIP = "192.168.4.1"; 

  Future<void> sendCommand(int command) async {
    final url = Uri.parse('http://$serverIP/command?value=$command');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Command sent: $command');
      } else {
        print('Failed to send command');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 181, 179, 179),
      appBar: AppBar(title: Text('D-pad Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
              iconSize: 50,
              onPressed: () => sendCommand(1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 50,
                  onPressed: () => sendCommand(3),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  iconSize: 50,
                  onPressed: () => sendCommand(2),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.stop),
              iconSize: 50,
              onPressed: () => sendCommand(0),
            ),
          ],
        ),
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(
    home: DpadControl(),
  ));
}
