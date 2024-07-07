import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceReleaseAndon {
  final String baseUrl = 'http://192.168.1.106:8082/operationsapi';

  Future<bool> releaseAndon(int productId) async {
    try {
      final url = Uri.parse('$baseUrl/releaseandon');
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
        return jsonResponse['message'] == 'Andon has been released!';
      } else {
        throw Exception('Failed to report Andon');
      }
    } catch (e) {
      print('Error releasing Andon: $e');
      return false;
    }
  }
}
