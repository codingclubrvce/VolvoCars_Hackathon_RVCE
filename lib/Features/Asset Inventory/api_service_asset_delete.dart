import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../resources/Strings.dart';

class ApiServiceDeleteAsset {
  static const String baseUrl = 'http://${Strings.localhost}/assetsapi';

  Future<bool> deleteAsset(int assetId) async {
    try {
      final url = Uri.parse('$baseUrl/deleteasset');
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'asset_id': assetId.toString(),
        },
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'Asset_ID: $assetId deleted successfully.') {
          return true;
        }
      }
    } catch (e) {
      print('Error deleting asset: $e');
    }
    return false;
  }
}
