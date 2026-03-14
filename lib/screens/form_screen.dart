import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class FormScreen extends StatefulWidget {
  final Map<String, dynamic>? Shoes;

  FormScreen({this.Shoes});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = SupabaseService();

  final _namaController = TextEditingController();
  final _brandController = TextEditingController();
  final _ukuranController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.Shoes != null) {
      _namaController.text = widget.Shoes!['Nama_Sepatu'] ?? '';
      _brandController.text = widget.Shoes!['Brand'] ?? '';
      _ukuranController.text = (widget.Shoes!['Ukuran'] ?? '').toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.Shoes == null ? "Tambah Sepatu" : "Edit Sepatu")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: "Nama Sepatu"),
                validator: (v) => v!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: "Brand"),
                validator: (v) => v!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: _ukuranController,
                decoration: InputDecoration(labelText: "Ukuran"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Harus diisi" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.Shoes == null) {
                      await _service.addShoe(
                        _namaController.text,
                        _brandController.text,
                        int.parse(_ukuranController.text),
                      );
                    } else {
                      await _service.updateShoe(
                        widget.Shoes!['id'],
                        _namaController.text,
                        _brandController.text,
                        int.parse(_ukuranController.text),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Simpan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}