import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceAddBreakdown {
  final String baseUrl = 'http://${Strings.localhost}/breakdownsapi';

  Future<bool> addBreakdown(Map<String, dynamic> breakdownData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/savebreakdown'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(breakdownData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      print('Failed to add breakdown: ${response.body}');
      throw Exception('Failed to add breakdown');
    }
  }
}
