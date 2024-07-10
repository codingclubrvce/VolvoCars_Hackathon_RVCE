import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceFailures {
  static const String url = 'http://${Strings.localhost}/failuresapi/fetchfailure';

  Future<List<Failure>> fetchFailures() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Failure> failures = data.map((item) => Failure.fromJson(item)).toList();
      return failures;
    } else {
      throw Exception('Failed to load failures');
    }
  }
}

class Failure {
  final int productId;
  final String timeStart;
  final String model;
  final String? workstation;
  final double idleTime;

  Failure({
    required this.productId,
    required this.timeStart,
    required this.model,
    required this.workstation,
    required this.idleTime,
  });

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      productId: json['product_id'],
      timeStart: json['time_start'],
      model: json['model'],
      workstation: json['workstation'],
      idleTime: json['idle_time'],
    );
  }
}
