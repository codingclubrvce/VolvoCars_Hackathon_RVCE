import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceDeleteSparePart {
  static const String baseUrl = 'http://192.168.1.106:8082/sparepartsapi';

  Future<bool> deleteSparePart(int spareId) async {
    try {
      final url = Uri.parse('$baseUrl/deletesparepart');
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'spare_id': spareId.toString(),
        },
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == 'Spare_id: $spareId deleted successfully.') {
          return true;
        }
      }
    } catch (e) {
      print('Error deleting spare part: $e');
    }
    return false;
  }
}
