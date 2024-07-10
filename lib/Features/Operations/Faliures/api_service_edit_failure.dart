import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceEditFailure {
  final String baseUrl = 'http://${Strings.localhost}/failuresapi';

  Future<bool> editFailure(Map<String, dynamic> failureData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/editfailure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(failureData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      throw Exception('Failed to edit failure');
    }
  }
}
