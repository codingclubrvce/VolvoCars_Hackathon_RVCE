import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServiceSearchProduct {
  static const String baseUrl = 'http://${Strings.localhost}/operationsapi/searchoperation';

  Future<ProductAssembly2?> fetchProduct(int product_ID) async {
    try {
      final url = Uri.parse('$baseUrl?product_ID=$product_ID');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return ProductAssembly2.fromJson(data);
      } else {
        throw Exception('Failed to load asset');
      }
    } catch (e) {
      print('Error fetching asset: $e');
      return null;
    }
  }
}

class ProductAssembly2 {
  final int productId;
  final String? modelName;
  final String? assemblyStartTime;
  final String? assemblyEndTime;
  final String? totalStipulatedTime;
  final int numberOfAndonsRaised;
  final bool andonStatus;
  final String? andonTimeStart;
  final String? andonTimeEnd;

  ProductAssembly2({
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

  factory ProductAssembly2.fromJson(Map<String, dynamic> json) {
    return ProductAssembly2(
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
