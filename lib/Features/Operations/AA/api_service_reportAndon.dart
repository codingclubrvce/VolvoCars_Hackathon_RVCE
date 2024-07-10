import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceReportAndon {
  final String baseUrl = 'http://${Strings.localhost}/operationsapi';

  Future<bool> reportAndon(int productId) async {
    try {
      final url = Uri.parse('$baseUrl/reportandon');
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'product_ID': productId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'] == 'Andon is active now!';
      } else {
        throw Exception('Failed to report Andon');
      }
    } catch (e) {
      print('Error reporting Andon: $e');
      return false;
    }
  }
}
