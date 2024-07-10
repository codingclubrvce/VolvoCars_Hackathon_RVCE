import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceAddProduct {
  final String baseUrl = 'http://${Strings.localhost}/operationsapi';

  Future<bool> addProduct(Map<String, dynamic> productData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/saveoperations'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['product_id'];
    } else {
      print('Failed to add asset: ${response.body}');
      throw Exception('Failed to add asset');
    }
  }
}
