import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/supabase_service.dart';

class FormScreen extends StatefulWidget {
  final Map<String, dynamic>? shoe;

  const FormScreen({Key? key, this.shoe}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final SupabaseService _service = SupabaseService();
  final _namaController = TextEditingController();
  final _brandController = TextEditingController();
  final _ukuranController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.shoe != null) {
      _namaController.text = widget.shoe!['Nama_Sepatu']?.toString() ?? '';
      _brandController.text = widget.shoe!['Brand']?.toString() ?? '';
      _ukuranController.text = widget.shoe!['Ukuran']?.toString() ?? '';
    }
  }

  Future<void> _saveData() async {
    if (_namaController.text.isEmpty || _ukuranController.text.isEmpty) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final String nama = _namaController.text;
      final String brand = _brandController.text;
      final int ukuran = int.parse(_ukuranController.text);

      if (widget.shoe == null) {
        await _service.addShoe(nama, brand, ukuran);
      } else {
        await _service.updateShoe(widget.shoe!['id'], nama, brand, ukuran);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoe == null ? "Tambah Sepatu" : "Edit Sepatu"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama Sepatu"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: "Brand"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ukuranController,
              decoration: const InputDecoration(labelText: "Ukuran"),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveData,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
