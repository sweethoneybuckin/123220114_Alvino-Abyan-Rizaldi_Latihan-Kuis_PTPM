import 'package:flutter/material.dart';
import 'OrderPage.dart';
import 'LoginPage.dart'; // Pastikan halaman LoginPage ada

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo @$username'),
        backgroundColor: const Color.fromARGB(255, 229, 144, 7),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Navigasi ke halaman login saat logout ditekan
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Gambar Header
          Stack(
            children: [
              Image.asset(
                'assets/foods.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 80, // Atur posisi teks agar tidak terlalu atas
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Latar belakang transparan
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    "Mau makan apa hari ini?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Subjudul
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Daftar Menu:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Grid Menu Makanan
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dua kolom
                childAspectRatio: 0.75, // Perbandingan lebar & tinggi card
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return MenuItemCard(menuItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Data Menu Makanan
final List<MenuItem> menuItems = [
  MenuItem(
    name: "Nasi Goreng",
    price: "Rp 15000",
    image: "assets/nasigoreng.jpg",
  ),
  MenuItem(
    name: "Mie Ayam",
    price: "Rp 12000",
    image: "assets/miayam.jpeg",
  ),
  MenuItem(
    name: "Sate Ayam",
    price: "Rp 20000",
    image: "assets/sate.jpg",
  ),
  MenuItem(
    name: "Bakso",
    price: "Rp 10000",
    image: "assets/baksooo.jpg",
  ),
];

// Model Data Menu
class MenuItem {
  final String name;
  final String price;
  final String image;

  MenuItem({required this.name, required this.price, required this.image});
}

// Widget untuk Card Menu
class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.image, height: 100, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            item.price,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(
                    name: item.name,
                    price: int.parse(item.price.replaceAll("Rp ", "").replaceAll(".", "")), // Ubah harga jadi integer
                    image: item.image,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 229, 144, 7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: const Text("Pesan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
