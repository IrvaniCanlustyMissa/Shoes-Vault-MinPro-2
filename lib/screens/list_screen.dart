import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import 'form_screen.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final SupabaseService _service = SupabaseService();
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  void _confirmDelete(BuildContext context, int id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hapus Koleksi?"),
        content: Text("Yakin ingin menghapus '$name' dari ShoesVault?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              await _service.deleteShoe(id);
              Navigator.pop(context);
              setState(() {});
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("$name berhasil dihapus")));
            },
            child: Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Cari nama sepatu...",
              prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5),
            ),
            onChanged: (value) =>
                setState(() => _searchQuery = value.toLowerCase()),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _service.getShoes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final allShoes = snapshot.data ?? [];
          final filteredShoes = allShoes.where((shoe) {
            final name = (shoe['Nama_Sepatu'] ?? '').toString().toLowerCase();
            return name.contains(_searchQuery);
          }).toList();

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: filteredShoes.length,
            itemBuilder: (context, index) {
              final shoe = filteredShoes[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(shoe: shoe),
                      ),
                    );
                  },
                  // ------------------------------------
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.inventory_2_rounded,
                      color: Colors.blueAccent,
                    ),
                  ),
                  title: Text(
                    shoe['Nama_Sepatu'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                  subtitle: Text(
                    "Brand: ${shoe['Brand']} | Size: ${shoe['Ukuran']}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormScreen(shoe: shoe),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(
                          context,
                          shoe['id'],
                          shoe['Nama_Sepatu'] ?? 'Sepatu',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
          setState(() {});
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
