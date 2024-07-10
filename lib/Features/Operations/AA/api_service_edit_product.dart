import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceEditProduct {
  final String baseUrl = 'http://${Strings.localhost}/operationsapi';

  Future<bool> editProduct(Map<String, dynamic> productData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/editoperation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['product_id'];
    } else {
      throw Exception('Failed to edit asset');
    }
  }
}
