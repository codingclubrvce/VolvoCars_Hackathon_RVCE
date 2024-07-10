import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../../resources/Strings.dart';

class ApiServicedownload2 {
  static const String fileUrl = 'http://${Strings.localhost}/operationsapi/downloadoperation';

  static Future<bool> downloadFile() async {
    try {
      Directory? storageDir = await getApplicationDocumentsDirectory();
      String savePath = '${storageDir?.path}/downloaded_file.pdf';

      var response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {
        File file = File(savePath);
        await file.writeAsBytes(response.bodyBytes);
        return true; // Download successful
      } else {
        print('File download error: ${response.statusCode}');
        return false; // Download failed due to HTTP error
      }
    } catch (e) {
      print('File download error: $e');
      return false; // Download failed due to exception
    }
  }

  static Future<String?> getFilePath() async {
    try {
      Directory? storageDir = await getApplicationDocumentsDirectory();
      String filePath = '${storageDir?.path}/AssetAssembly.pdf';
      return filePath;
    } catch (e) {
      print('Error getting file path: $e');
      return null;
    }
  }
}
