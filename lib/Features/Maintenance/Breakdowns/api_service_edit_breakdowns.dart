import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceEditBreakdown {
  final String baseUrl = 'http://192.168.1.106:8082/breakdownsapi';

  Future<bool> editBreakdown(Map<String, dynamic> breakdownData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/editbreakdown'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(breakdownData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      throw Exception('Failed to edit failure');
    }
  }
}
