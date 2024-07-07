import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceBreakdowns {
  static const String breakdownUrl = 'http://192.168.1.106:8082/breakdownsapi/fetchbreakdown';

  Future<List<Breakdown>> fetchBreakdowns() async {
    final response = await http.get(Uri.parse(breakdownUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Breakdown> breakdowns = data.map((item) => Breakdown.fromJson(item)).toList();
      return breakdowns;
    } else {
      throw Exception('Failed to load breakdowns');
    }
  }
}

class Breakdown {
  final int assetId;
  final String assetName;
  final String assetDescription;
  final String workstation;
  final String lastTask;
  final DateTime lastServiceDate;
  final String breakdownReason;
  final String offlineTime;

  Breakdown({
    required this.assetId,
    required this.assetName,
    required this.assetDescription,
    required this.workstation,
    required this.lastTask,
    required this.lastServiceDate,
    required this.breakdownReason,
    required this.offlineTime,
  });

  factory Breakdown.fromJson(Map<String, dynamic> json) {
    return Breakdown(
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

