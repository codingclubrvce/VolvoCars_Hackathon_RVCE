import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../resources/Strings.dart';

class ApiServiceAddAsset {
  final String baseUrl = 'http://${Strings.localhost}/assetsapi';

  Future<bool> addAsset(Map<String, dynamic> assetData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/saveasset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(assetData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      print('Failed to add asset: ${response.body}');
      throw Exception('Failed to add asset');
    }
  }
}
