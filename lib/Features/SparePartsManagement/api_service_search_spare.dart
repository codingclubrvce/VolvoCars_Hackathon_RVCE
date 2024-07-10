import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../resources/Strings.dart';

class ApiServiceSearchSparePart {
  static const String baseUrl = 'http://${Strings.localhost}/sparepartsapi/searchsparepart';

  Future<SparePart2?> fetchSparePart(int spareId) async {
    try {
      final url = Uri.parse('$baseUrl?spare_id=$spareId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return SparePart2.fromJson(data);
      } else {
        throw Exception('Failed to load spare part');
      }
    } catch (e) {
      print('Error fetching spare part: $e');
      return null;
    }
  }
}

class SparePart2 {
  final int spareId;
  final String spareName;
  final double sparePartCost;
  final String vendorInfo;
  final String assetToBeReplacedWith;
  final String issue;
  final String location;
  final int unitNo;
  final bool physicalVerification;

  SparePart2({
    required this.spareId,
    required this.spareName,
    required this.sparePartCost,
    required this.vendorInfo,
    required this.assetToBeReplacedWith,
    required this.issue,
    required this.location,
    required this.unitNo,
    required this.physicalVerification,
  });

  factory SparePart2.fromJson(Map<String, dynamic> json) {
    return SparePart2(
      spareId: json['spare_id'],
      spareName: json['spare_name'],
      sparePartCost: json['spare_part_cost'].toDouble(),
      vendorInfo: json['vendor_info'],
      assetToBeReplacedWith: json['asset_to_be_replaced_with'],
      issue: json['issue'],
      location: json['location'],
      unitNo: json['unitno'],
      physicalVerification: json['physical_verification'],
    );
  }
}
