import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../resources/Strings.dart';

class ApiServiceEditAsset {
  final String baseUrl = 'http://${Strings.localhost}/assetsapi';

  Future<bool> editAsset(Map<String, dynamic> assetData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/editasset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(assetData),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['editresult'];
    } else {
      throw Exception('Failed to edit asset');
    }
  }
}
