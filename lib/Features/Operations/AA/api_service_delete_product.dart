import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceDeleteProduct {
  static const String baseUrl = 'http://192.168.1.106:8082/operationsapi';

  Future<bool> deleteProduct(int productID) async {
    try {
      final url = Uri.parse('$baseUrl/deleteoperation');
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'product_ID': productID.toString(),
        },
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'ProductID: $productID deleted successfully.') {
          return true;
        }
      }
    } catch (e) {
      print('Error deleting asset: $e');
    }
    return false;
  }
}
