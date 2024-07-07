import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceSpareParts {
  static const String url = 'http://192.168.1.106:8082/sparepartsapi/fetchsparepart';

  Future<List<SparePart>> fetchSpareParts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response);
      List<dynamic> data = jsonDecode(response.body);
      List<SparePart> spareParts = data.map((item) => SparePart.fromJson(item)).toList();
      return spareParts;
    } else {
      throw Exception('Failed to load spare parts');
    }
  }
}

class SparePart {
  final int spareId;
  final String spareName;
  final double sparePartCost;
  final String vendorInfo;
  final String assetToBeReplacedWith;
  final String issue;
  final String location;
  final int unitNo;
  final bool physicalVerification;

  SparePart({
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

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
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
