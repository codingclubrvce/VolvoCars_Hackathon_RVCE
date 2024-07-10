import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceOperationsFetch {
  static const String url = 'http://${Strings.localhost}/operationsapi/fetchoperations';

  Future<List<ProductAssembly>> fetchAssets() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response);
      List<dynamic> data = jsonDecode(response.body);
      List<ProductAssembly> assets = data.map((item) => ProductAssembly.fromJson(item)).toList();
      return assets;
    } else {
      throw Exception('Failed to load assets');
    }
  }
}

class ProductAssembly {
  final int productId;
  final String? modelName;
  final String? assemblyStartTime;
  final String? assemblyEndTime;
  final String? totalStipulatedTime;
  final int numberOfAndonsRaised;
  final bool andonStatus;
  final String? andonTimeStart;
  final String? andonTimeEnd;

  ProductAssembly({
    required this.productId,
    this.modelName,
    this.assemblyStartTime,
    this.assemblyEndTime,
    this.totalStipulatedTime,
    required this.numberOfAndonsRaised,
    required this.andonStatus,
    this.andonTimeStart,
    this.andonTimeEnd,
  });

  factory ProductAssembly.fromJson(Map<String, dynamic> json) {
    return ProductAssembly(
      productId: json['product_id'],
      modelName: json['model_name'],
      assemblyStartTime: json['assembly_start_time'],
      assemblyEndTime: json['assembly_end_time'],
      totalStipulatedTime: json['total_stipulated_time'],
      numberOfAndonsRaised: json['number_of_andons_raised'],
      andonStatus: json['andon_status'],
      andonTimeStart: json['andon_time_start'],
      andonTimeEnd: json['andon_time_end'],
    );
  }
}
