import 'package:cloud_firestore/cloud_firestore.dart';
import 'setting/setting.dart';
import 'package:test_1/pages/controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String? ipAddress;
  final _firestore = FirebaseFirestore.instance;
  final _nameController = TextEditingController();

  void _showIPInputDialog() {
    final ipController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Enter IP Address',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3F3F3F),
            ),
          ),
          content: TextField(
            controller: ipController,
            decoration: InputDecoration(labelText: 'IP Address'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF3F3F3F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF19000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    ipAddress = ipController.text.isNotEmpty
                        ? ipController.text
                        : null; // Simpan IP
                  });
                  Navigator.of(context).pop(); // Tutup dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('IP Address saved: $ipAddress'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF3F3F3F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengambil data project dari Firestore
  Future<List<Map<String, String>>> getProjects() async {
    try {
      final snapshot = await _firestore.collection('projects').get();

      final projects = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        final name =
            data.containsKey('name') ? data['name'] as String : 'No Name';
        final jumlah = data.containsKey('jumlah')
            ? data['jumlah'] as int
            : 0; // Mengambil jumlah, jika tidak ada default 0

        return {
          'id': doc.id,
          'name': name,
          'jumlah': jumlah.toString(),
        };
      }).toList();

      return projects;
    } catch (e) {
      print('Error fetching projects: $e');
      return [];
    }
  }

  // Fungsi untuk menambahkan project baru ke Firestore
  Future<void> addProject(String name) async {
    try {
      await _firestore.collection('projects').add({
        'name': name,
        'jumlah': 0, // Menyimpan jumlah dengan nilai default 0
      });
      setState(() {}); // Memperbarui tampilan setelah menambahkan project
    } catch (e) {
      print('Error adding project: $e');
    }
  }

  // Dialog untuk menambahkan project baru
  void _showAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Warna latar belakang dialog
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Membuat sudut dialog melengkung
          ),
          title: Text(
            'Add Project',
            style: TextStyle(
              fontSize: 25.0, // Ukuran font judul
              fontWeight: FontWeight.bold, // Teks tebal
              color: Color(0xFF3F3F3F), // Warna teks judul
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Project Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.0, // Ukuran font tombol
                  color: Color(0xFF3F3F3F), // Warna teks tombol
                  fontWeight: FontWeight.bold, // Berat font tombol
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF19000), // Warna latar tombol
                borderRadius: BorderRadius.circular(10), // Sudut melengkung
              ),
              child: TextButton(
                onPressed: () {
                  final projectName = _nameController.text;
                  if (projectName.isNotEmpty) {
                    addProject(projectName);
                    _nameController.clear();
                    Navigator.of(context).pop();
                    setState(
                        () {}); // Tambahkan setState() untuk merefresh halaman
                  }
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16.0, // Ukuran font tombol
                    color: Color(0xFF3F3F3F), // Warna teks putih
                    fontWeight: FontWeight.bold, // Teks tebal
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Center(
            child: Image.asset(
              "assets/Robocorn.png",
              width: 130, // Ganti dengan URL gambar yang Anda inginkan
            ),
          ),
        ), // Gambar tetap berada di tengah
        backgroundColor: Color(0xFF3F3F3F),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: 0), // Geser ikon WiFi ke kiri sedikit
            child: IconButton(
              icon: Icon(
                ipAddress == null ? Icons.wifi_off : Icons.wifi,
                color: ipAddress == null ? Colors.white : Color(0xFFF19000),
                size: 30,
              ),
              onPressed: _showIPInputDialog,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: 8), // Geser ikon WiFi ke kiri sedikit
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF3F3F3F),
        child: Column(
          children: [
            Container(
              width: double.infinity, // Lebar penuh
              margin: EdgeInsets.only(
                  right: 16.0,
                  left: 16,
                  bottom: 16,
                  top: 0), // Margin di sekitar tombol
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.0), // Tinggi tombol
                  backgroundColor: Color(0xFFF19000), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Radius sudut
                  ),
                ),
                onPressed: _showAddProjectDialog,
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Agar tinggi tombol sesuai konten
                  children: [
                    Icon(
                      Icons.add_box, // Ikon add_box
                      color: Color(0xFF3F3F3F), // Warna ikon
                      size: 40.0, // Ukuran ikon
                    ),
                    Text(
                      'New project',
                      style: TextStyle(
                        fontSize: 18.0, // Ukuran font
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Warna teks
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity, // Lebar penuh
              margin:
                  EdgeInsets.only(left: 16.0, top: 0), // Margin kiri dan atas
              child: Text(
                'Projects',
                textAlign: TextAlign.left, // Rata kiri
                style: TextStyle(
                  fontSize: 18.0, // Ukuran font
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future: getProjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                      'No projects available.',
                      style: TextStyle(
                        fontSize: 15.0, // Ukuran font
                        color: Colors.white, // Warna teks
                      ),
                    ));
                  } else {
                    final projects = snapshot.data!;
                    return ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color(0xFFF19000),
                          child: ListTile(
                            title: Text(
                              project['name'] ?? 'No Name',
                              style: TextStyle(
                                color: Color(0xFF3F3F3F),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Jumlah : ${project['jumlah']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'Rename') {
                                  _showRenameDialog(
                                      project['id']!, project['name']!);
                                } else if (value == 'Delete') {
                                  _showDeleteConfirmation(project['id']!);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: 'Rename',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit,
                                          color: Color(
                                              0xFF3F3F3F)), // Ikon hapus dengan warna merah
                                      SizedBox(
                                          width:
                                              8), // Spasi antara ikon dan teks
                                      Text(
                                        'Rename',
                                        style: TextStyle(
                                          color: Color(0xFF3F3F3F),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,
                                          color: Color(
                                              0xFF3F3F3F)), // Ikon hapus dengan warna merah
                                      SizedBox(
                                          width:
                                              8), // Spasi antara ikon dan teks
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Color(0xFF3F3F3F),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Ketika project card diklik, navigasi ke halaman detail
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectDetailScreen(
                                    projectId: project['id']!,
                                    ip: ipAddress ?? '',
                                  ),
                                ),
                              ).then((_) {
                                // Fungsi untuk otomatis menyinkronkan data saat kembali
                                setState(() {});
                              });
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog untuk rename project
  void _showRenameDialog(String projectId, String currentName) {
    TextEditingController renameController =
        TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Warna latar belakang dialog
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Membuat sudut dialog melengkung
          ),
          title: Text(
            'Rename Project',
            style: TextStyle(
              fontSize: 25.0, // Ukuran font judul
              fontWeight: FontWeight.bold, // Teks tebal
              color: Color(0xFF3F3F3F), // Warna teks judul
            ),
          ),
          content: TextField(
            controller: renameController,
            decoration: InputDecoration(labelText: 'New Project Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.0, // Ukuran font tombol
                  color: Color(0xFF3F3F3F), // Warna teks tombol
                  fontWeight: FontWeight.bold, // Berat font tombol
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF19000), // Warna latar tombol
                borderRadius: BorderRadius.circular(10), // Sudut melengkung
              ),
              child: TextButton(
                onPressed: () async {
                  final newName = renameController.text;
                  if (newName.isNotEmpty) {
                    await _firestore
                        .collection('projects')
                        .doc(projectId)
                        .update({
                      'name': newName,
                    });
                    Navigator.of(context).pop();
                    setState(() {}); // Update UI
                  }
                },
                child: Text(
                  'Rename',
                  style: TextStyle(
                    fontSize: 16.0, // Ukuran font tombol
                    color: Color(0xFF3F3F3F), // Warna teks putih
                    fontWeight: FontWeight.bold, // Teks tebal
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk konfirmasi delete project
  void _showDeleteConfirmation(String projectId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Warna latar belakang dialog
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Membuat sudut dialog melengkung
          ),
          title: Text(
            'Delete Project',
            style: TextStyle(
              fontSize: 25.0, // Ukuran font judul
              fontWeight: FontWeight.bold, // Teks tebal
              color: Color(0xFF3F3F3F), // Warna teks judul
            ),
          ),
          content: Text('Are you sure you want to delete this project?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.0, // Ukuran font tombol
                  color: Color(0xFF3F3F3F), // Warna teks tombol
                  fontWeight: FontWeight.bold, // Berat font tombol
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF19000), // Warna latar tombol
                borderRadius: BorderRadius.circular(10), // Sudut melengkung
              ),
              child: TextButton(
                onPressed: () async {
                  await _firestore
                      .collection('projects')
                      .doc(projectId)
                      .delete();
                  Navigator.of(context).pop();
                  setState(() {}); // Update UI
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16.0, // Ukuran font tombol
                    color: Color(0xFF3F3F3F), // Warna teks putih
                    fontWeight: FontWeight.bold, // Teks tebal
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
