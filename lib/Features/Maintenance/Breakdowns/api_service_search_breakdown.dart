import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceSearchBreakdown {
  static const String baseUrl = 'http://192.168.1.106:8082/breakdownsapi/searchbreakdown';

  Future<Breakdown2?> searchBreakdown(int productId) async {
    try {
      final url = Uri.parse('$baseUrl?product_id=$productId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Breakdown2.fromJson(data);
      } else {
        throw Exception('Failed to load breakdown');
      }
    } catch (e) {
      print('Error fetching breakdown: $e');
      return null;
    }
  }
}

class Breakdown2 {
  final int assetId;
  final String assetName;
  final String assetDescription;
  final String workstation;
  final String lastTask;
  final DateTime lastServiceDate;
  final String breakdownReason;
  final String offlineTime;

  Breakdown2({
    required this.assetId,
    required this.assetName,
    required this.assetDescription,
    required this.workstation,
    required this.lastTask,
    required this.lastServiceDate,
    required this.breakdownReason,
    required this.offlineTime,
  });

  factory Breakdown2.fromJson(Map<String, dynamic> json) {
    return Breakdown2(
      assetId: json['asset_id'],
      assetName: json['asset_name'],
      assetDescription: json['asset_description'],
      workstation: json['workstation'],
      lastTask: json['last_task'],
      lastServiceDate: DateTime.parse(json['last_service_date']),
      breakdownReason: json['breakdown_reason'],
      offlineTime: json['offline_time'],
    );
  }
}
