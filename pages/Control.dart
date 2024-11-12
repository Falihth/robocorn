import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Control extends StatefulWidget {
  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  // Deklarasi IP server ESP8266
  final String serverIP = "192.168.4.1";

  // Fungsi untuk mengirim perintah ke ESP8266
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
  void initState() {
    super.initState();
    // Mengatur orientasi menjadi landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Mengembalikan orientasi ke default (potrait) saat halaman ditutup
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  // Opacity gambar saat disentuh
  double _opacityKiri = 1.0;
  double _opacityKanan = 1.0;
  double _opacityAtas = 1.0;
  double _opacityBawah = 1.0;
  double _opacityLogo = 1.0;

  // Fungsi untuk mengurangi opacity saat gambar disentuh
  void _onTapDownKiri() {
    setState(() {
      _opacityKiri = 0.5; // Mengurangi opacity saat disentuh
    });
  }

  void _onTapUpKiri() {
    setState(() {
      _opacityKiri = 1.0; // Kembalikan ke opacity normal saat dilepaskan
    });
  }

  void _onTapDownKanan() {
    setState(() {
      _opacityKanan = 0.5; // Mengurangi opacity saat disentuh
    });
  }

  void _onTapUpKanan() {
    setState(() {
      _opacityKanan = 1.0; // Kembalikan ke opacity normal saat dilepaskan
    });
  }

  void _onTapDownAtas() {
    setState(() {
      _opacityAtas = 0.5; // Mengurangi opacity saat disentuh
    });
  }

  void _onTapUpAtas() {
    setState(() {
      _opacityAtas = 1.0; // Kembalikan ke opacity normal saat dilepaskan
    });
  }

  void _onTapDownBawah() {
    setState(() {
      _opacityBawah = 0.5; // Mengurangi opacity saat disentuh
    });
  }

  void _onTapUpBawah() {
    setState(() {
      _opacityBawah = 1.0; // Kembalikan ke opacity normal saat dilepaskan
    });
  } // Opacity awal logo

  void _onTapDownLogo() {
    setState(() {
      _opacityLogo = 0.5; // Ubah opacity menjadi 50% saat ditekan
    });
  }

  void _onTapUpLogo() {
    setState(() {
      _opacityLogo = 1.0; // Kembalikan opacity ke 100% saat dilepas
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            // Setengah kiri (Hitam)
            Expanded(
              flex: 1,
              child: Container(
                height: 480, // Mengatur tinggi container
                color: Color(0xFFF19000),
                child: Stack(
                  children: [
                    // Konten utama yang sudah ada sebelumnya (Row)
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Gambar pertama di sebelah kiri dengan efek opacity
                          GestureDetector(
                            onTapDown: (_) => _onTapDownKiri(),
                            onTapUp: (_) => _onTapUpKiri(),
                            onTapCancel: _onTapUpKiri,
                            onTap: () {
                              // Tambahkan aksi di sini seperti onPressed
                              _onTapUpKiri(); // Kembalikan opacity ke normal
                              sendCommand(
                                  3); // Kirim perintah ke ESP8266 untuk "kiri"
                            },
                            child: Opacity(
                              opacity: _opacityKiri,
                              child: Image.asset(
                                'assets/kiri3.png',
                                width: 190,
                                height: 360,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(width: 20), // Jarak antar gambar
                          // Gambar kedua di sebelah kanan dengan efek opacity
                          GestureDetector(
                            onTapDown: (_) => _onTapDownKanan(),
                            onTapUp: (_) => _onTapUpKanan(),
                            onTapCancel: _onTapUpKanan,
                            onTap: () {
                              // Tambahkan aksi di sini seperti onPressed
                              _onTapUpKiri(); // Kembalikan opacity ke normal
                              sendCommand(
                                  2); // Kirim perintah ke ESP8266 untuk "kiri"
                            },
                            child: Opacity(
                              opacity: _opacityKanan,
                              child: Image.asset(
                                'assets/kanan3.png',
                                width: 190,
                                height: 360,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Gambar logo dengan efek opacity saat disentuh
                    Positioned(
                      top: 20,
                      left: 20,
                      child: GestureDetector(
                        onTapDown: (_) => _onTapDownLogo(),
                        onTapUp: (_) => _onTapUpLogo(),
                        onTapCancel: _onTapUpLogo,
                        child: Opacity(
                          opacity: _opacityLogo,
                          child: Image.asset(
                            'assets/funnel.png', // Ganti dengan path gambar Anda
                            width: 80, // Sesuaikan ukuran logo
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Setengah kanan (Merah)
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xFF3F3F3F), // Warna latar belakang
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gambar pertama di bagian atas dengan efek opacity saat disentuh
                    GestureDetector(
                      onTapDown: (_) => _onTapDownAtas(), // Saat gambar ditekan
                      onTapUp: (_) => _onTapUpAtas(), // Saat gambar dilepaskan
                      onTapCancel: _onTapUpAtas, // Jika tindakan dibatalkan
                      onTap: () {
                        // Tambahkan aksi di sini seperti onPressed
                        _onTapUpKiri(); // Kembalikan opacity ke normal
                        sendCommand(
                            1); // Kirim perintah ke ESP8266 untuk "kiri"
                      },
                      child: Opacity(
                        opacity: _opacityAtas, // Mengubah opacity sesuai state
                        child: Image.asset(
                          'assets/atas3.png', // Gambar pertama
                          width: 350,
                          height: 200,
                          fit: BoxFit.contain, // Menyesuaikan gambar
                        ),
                      ),
                    ), // Jarak antar gambar secara vertikal
                    // Gambar kedua tepat di bawah gambar pertama dengan efek opacity saat disentuh
                    GestureDetector(
                      onTapDown: (_) =>
                          _onTapDownBawah(), // Saat gambar ditekan
                      onTapUp: (_) => _onTapUpBawah(), // Saat gambar dilepaskan
                      onTapCancel: _onTapUpBawah, // Jika tindakan dibatalkan
                      onTap: () {
                        // Tambahkan aksi di sini seperti onPressed
                        _onTapUpKiri(); // Kembalikan opacity ke normal
                        sendCommand(
                            0); // Kirim perintah ke ESP8266 untuk "kiri"
                      },
                      child: Opacity(
                        opacity: _opacityBawah, // Mengubah opacity sesuai state
                        child: Image.asset(
                          'assets/bawah3.png', // Gambar kedua
                          width: 350,
                          height: 200,
                          fit: BoxFit.contain, // Menyesuaikan gambar
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
