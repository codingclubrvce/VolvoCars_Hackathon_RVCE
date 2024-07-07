import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceSearchFailure {
  static const String baseUrl = 'http://192.168.1.106:8082/failuresapi/searchfailure';

  Future<Failure2?> fetchFailure(int productId) async {
    try {
      final url = Uri.parse('$baseUrl?product_id=$productId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Failure2.fromJson(data);
      } else {
        throw Exception('Failed to load failure');
      }
    } catch (e) {
      print('Error fetching failure: $e');
      return null;
    }
  }
}

class Failure2 {
  final int productId;
  final String timeStart;
  final String model;
  final String? workstation;
  final int idleTime;

  Failure2({
    required this.productId,
    required this.timeStart,
    required this.model,
    required this.workstation,
    required this.idleTime,
  });

  factory Failure2.fromJson(Map<String, dynamic> json) {
    return Failure2(
      productId: json['product_id'],
      timeStart: json['time_start'],
      model: json['model'],
      workstation: json['workstation'],
      idleTime: json['idle_time'],
    );
  }
}
