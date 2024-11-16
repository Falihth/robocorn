import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Control extends StatefulWidget {
  final String serverIP; // Menambahkan parameter serverIP

  // Konstruktor menerima serverIP
  Control({required this.serverIP});

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  late String serverIP;
  TextEditingController _ipController = TextEditingController(); // Menambahkan controller untuk input IP

  @override
  void initState() {
    super.initState();
    serverIP = widget.serverIP; // Menyimpan nilai IP yang diterima
  }

  @override
  void dispose() {
    _ipController.dispose(); // Pastikan untuk dispose controller saat halaman dihapus
    super.dispose();
  }

  // Fungsi untuk mengupdate IP
  void _updateServerIP() {
    setState(() {
      serverIP = _ipController.text; // Mengambil IP dari text controller
    });
    print('Server IP updated to: $serverIP');
  }

  // Fungsi untuk mengirim perintah ke server
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

  double _opacityKiri = 1.0;
  double _opacityKanan = 1.0;
  double _opacityAtas = 1.0;
  double _opacityBawah = 1.0;

  void _onTapDown(String direction) {
    setState(() {
      switch (direction) {
        case 'kiri':
          _opacityKiri = 0.5;
          break;
        case 'kanan':
          _opacityKanan = 0.5;
          break;
        case 'atas':
          _opacityAtas = 0.5;
          break;
        case 'bawah':
          _opacityBawah = 0.5;
          break;
      }
    });
  }

  void _onTapUp(String direction) {
    setState(() {
      switch (direction) {
        case 'kiri':
          _opacityKiri = 1.0;
          break;
        case 'kanan':
          _opacityKanan = 1.0;
          break;
        case 'atas':
          _opacityAtas = 1.0;
          break;
        case 'bawah':
          _opacityBawah = 1.0;
          break;
      }
    });
    sendCommand(0); // Kirim perintah 0 untuk menghentikan gerakan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control Page'),
        backgroundColor: Color(0xFF3F3F3F),
      ),
      body: Column(
        children: [
          // Input field untuk Server IP
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'Enter Server IP',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              onSubmitted: (value) {
                _updateServerIP(); // Update IP ketika tombol submit ditekan
              },
            ),
          ),
          // Tombol untuk mengupdate IP
          ElevatedButton(
            onPressed: _updateServerIP,
            child: Text('Update IP'),
          ),
          // Kontrol pergerakan
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 480,
                  color: Color(0xFFF19000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTapDown: (_) => _onTapDown('kiri'),
                        onTapUp: (_) => _onTapUp('kiri'),
                        onTapCancel: () => _onTapUp('kiri'),
                        onTap: () {
                          sendCommand(3); // Kirim perintah gerakan kiri
                        },
                        child: Opacity(
                          opacity: _opacityKiri,
                          child: Image.asset(
                            '/home/falih-taufiqul-hakim/Documents/Mobile/2/flutter_application_1/lib/assets/kiri3.png',
                            width: 190,
                            height: 360,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTapDown: (_) => _onTapDown('kanan'),
                        onTapUp: (_) => _onTapUp('kanan'),
                        onTapCancel: () => _onTapUp('kanan'),
                        onTap: () {
                          sendCommand(2); // Kirim perintah gerakan kanan
                        },
                        child: Opacity(
                          opacity: _opacityKanan,
                          child: Image.asset(
                            '/home/falih-taufiqul-hakim/Documents/Mobile/2/flutter_application_1/lib/assets/kanan3.png',
                            width: 190,
                            height: 360,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xFF3F3F3F),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTapDown: (_) => _onTapDown('atas'),
                        onTapUp: (_) => _onTapUp('atas'),
                        onTapCancel: () => _onTapUp('atas'),
                        onTap: () {
                          sendCommand(1); // Kirim perintah gerakan atas
                        },
                        child: Opacity(
                          opacity: _opacityAtas,
                          child: Image.asset(
                            '/home/falih-taufiqul-hakim/Documents/Mobile/2/flutter_application_1/lib/assets/atas3.png',
                            width: 350,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (_) => _onTapDown('bawah'),
                        onTapUp: (_) => _onTapUp('bawah'),
                        onTapCancel: () => _onTapUp('bawah'),
                        onTap: () {
                          sendCommand(4); // Kirim perintah gerakan bawah
                        },
                        child: Opacity(
                          opacity: _opacityBawah,
                          child: Image.asset(
                            '/home/falih-taufiqul-hakim/Documents/Mobile/2/flutter_application_1/lib/assets/bawah3.png',
                            width: 350,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
