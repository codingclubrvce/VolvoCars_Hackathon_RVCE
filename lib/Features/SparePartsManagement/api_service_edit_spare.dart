import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceEditSparePart {
  final String baseUrl = 'http://192.168.1.106:8082/sparepartsapi';

  Future<bool> editSparePart(Map<String, dynamic> sparePartData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/editsparepart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sparePartData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      throw Exception('Failed to edit spare part');
    }
  }
}
