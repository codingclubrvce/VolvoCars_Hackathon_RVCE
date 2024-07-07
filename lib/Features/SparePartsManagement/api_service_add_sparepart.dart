import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceAddSparePart {
  final String baseUrl = 'http://192.168.1.106:8082/sparepartsapi';

  Future<bool> addSparePart(Map<String, dynamic> sparePartData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/savesparepart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sparePartData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      print('Failed to add spare part: ${response.body}');
      throw Exception('Failed to add spare part');
    }
  }
}
