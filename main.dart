import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cari dan Hubungkan WiFi Nodemcu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WifiScanPage(),
    );
  }
}

class WifiScanPage extends StatefulWidget {
  @override
  _WifiScanPageState createState() => _WifiScanPageState();
}

class _WifiScanPageState extends State<WifiScanPage> {
  List<WifiNetwork?> wifiNetworks = [];

  @override
  void initState() {
    super.initState();
    scanWifiNetworks();
  }

  Future<void> scanWifiNetworks() async {
    List<WifiNetwork?> networks = await WiFiForIoTPlugin.loadWifiList();
    setState(() {
      wifiNetworks = networks;
    });
  }

  Future<void> connectToNetwork(String ssid, String password) async {
    bool isConnected = await WiFiForIoTPlugin.connect(
      ssid,
      password: password,
      security: NetworkSecurity.WPA,
    );
    if (isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terhubung ke $ssid!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal terhubung ke $ssid!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pindai dan Hubungkan WiFi Nodemcu"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: scanWifiNetworks,
          ),
        ],
      ),
      body: wifiNetworks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: wifiNetworks.length,
              itemBuilder: (context, index) {
                final network = wifiNetworks[index];
                return ListTile(
                  title: Text(network?.ssid ?? "Unknown"),
                  onTap: () async {
                    String password = ""; // Masukkan password jika diperlukan
                    await connectToNetwork(network!.ssid!, password);
                  },
                );
              },
            ),
    );
  }
}
