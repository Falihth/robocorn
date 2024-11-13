import 'package:flutter/material.dart';
import 'controller_page.dart';

class CornApp extends StatelessWidget {
  const CornApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF3F3F3F),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 140),
            child: Image.asset(
              "assets/Robocorn.png",
              width: 160, // Ganti dengan URL gambar yang Anda inginkan
            ),
          ), // Gambar tetap berada di tengah
          backgroundColor: Color(0xFF3F3F3F),
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: 0), // Geser ikon WiFi ke kiri sedikit
              child: IconButton(
                icon: Icon(
                  Icons.wifi,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Control()),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: 8), // Geser ikon WiFi ke kiri sedikit
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 0, bottom: 0, right: 30, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New project button
              InkWell(
                onTap: () {
                  // Aksi ketika tombol "New Project" ditekan
                  print("New Project tapped!");
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                    color: Color(0xFFF19000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_box,
                        color: Color(0xFF3F3F3F),
                        size: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "New Project",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Projects list
              Text(
                "Projects",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              projectCard("Kebun 1"), SizedBox(height: 15),
              projectCard("Kebun 2"), SizedBox(height: 15),
              projectCard("Kebun 3"), SizedBox(height: 15),
              projectCard("Kebun 4"), SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat kartu proyek yang dapat ditekan
  Widget projectCard(String projectName) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.only(bottom: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.orange,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          title: Text(
            projectName,
            style: TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Last update: 10.12.2024 15:00",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.more_horiz, color: Color(0xFF3F3F3F)),
        ),
      ),
    );
  }
}
