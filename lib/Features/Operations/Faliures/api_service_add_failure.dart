import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceAddFailure {
  final String baseUrl = 'http://192.168.1.106:8082/failuresapi';

  Future<bool> addFailure(Map<String, dynamic> failureData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/savefailure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(failureData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      print('Failed to add failure: ${response.body}');
      throw Exception('Failed to add failure');
    }
  }
}
