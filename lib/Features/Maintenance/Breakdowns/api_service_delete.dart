import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceDeleteBreakdown {
  static const String baseUrl = 'http://${Strings.localhost}/breakdownsapi';

  Future<bool> deleteBreakdown(int productId) async {
    try {
      final url = Uri.parse('$baseUrl/deletebreakdown');
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'product_id': productId.toString(),
        },
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'Product_ID: $productId deleted successfully.') {
          return true;
        }
      }
    } catch (e) {
      print('Error deleting failure: $e');
    }
    return false;
  }
}
