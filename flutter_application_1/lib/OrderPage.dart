import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final String name;
  final int price;
  final String image;

  const OrderPage({super.key, required this.name, required this.price, required this.image});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _amountController = TextEditingController();
  int totalPrice = 0;

  void calculateTotalPrice() {
    setState(() {
      int amount = int.tryParse(_amountController.text) ?? 0;
      totalPrice = widget.price * amount;
    });
  }

  void showDialogMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(title, textAlign: TextAlign.center),
          content: Text(message, textAlign: TextAlign.center),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  void handleSubmit() {
    int amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      showDialogMessage("Jumlah Tidak Valid", "Isi jumlah pesanan terlebih dahulu");
    } else {
      calculateTotalPrice();
      showDialogMessage("Pesanan Berhasil", "Terima kasih telah melakukan pemesanan!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        backgroundColor: const Color.fromARGB(255, 229, 144, 7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(widget.image, height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(widget.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Harga: Rp ${widget.price}", style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan Jumlah",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => calculateTotalPrice(),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 144, 7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),

            const SizedBox(height: 20),
            Text(
              "Total Harga: Rp $totalPrice",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
