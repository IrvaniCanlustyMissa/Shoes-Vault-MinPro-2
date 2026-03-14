import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getShoes() async {
    final response = await _client
        .from('Shoes')
        .select('*')
        .order('id', ascending: false);
    return response;
  }

  Future<void> addShoe(String name, String brand, int size) async {
    await _client.from('Shoes').insert({
      'Nama_Sepatu': name,
      'Brand': brand,
      'Ukuran': size,
    });
  }

  Future<void> updateShoe(int id, String name, String brand, int size) async {
    await _client
        .from('Shoes')
        .update({'Nama_Sepatu': name, 'Brand': brand, 'Ukuran': size})
        .eq('id', id);
  }

  Future<void> deleteShoe(int id) async {
    await _client.from('Shoes').delete().eq('id', id);
  }
}
