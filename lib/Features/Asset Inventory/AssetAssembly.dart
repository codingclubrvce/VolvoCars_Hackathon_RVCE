import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import '../../Widgets/AssetAssemblyCard.dart';
import 'Api_service_assets.dart';
import 'AssetAssembly_lower.dart';
import 'AssetForm.dart';
import 'api_service_search.dart';
import 'api_service_download.dart'; // Make sure to import the updated ApiServiceDownload class

class AssetAssembly extends StatefulWidget {
  AssetAssembly({Key? key}) : super(key: key);

  @override
  _AssetAssemblyState createState() => _AssetAssemblyState();
}

class _AssetAssemblyState extends State<AssetAssembly> {
  final ApiServiceAssets apiService = ApiServiceAssets();
  final ApiServiceSearchAsset apiServiceSearch = ApiServiceSearchAsset();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF182871),
        title: Text(
          "Volvo",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AssetCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Find Asset by ID',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _searchAsset,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: AssetLower(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SpeedDial(
            animatedIcon:AnimatedIcons.menu_close,
            backgroundColor: Colors.white,
            spaceBetweenChildren: 8.0,
            spacing: 8.0,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            children:[
              SpeedDialChild(
                child: Icon(Icons.add, color: Colors.white),
                label: 'Add Asset Assembly',
                backgroundColor: Color(0xFF182871),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: AssetForm(),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },

              ),
              SpeedDialChild(
                child: Icon(Icons.file_download, color: Colors.white),
                label: 'Download Asset Assembly File',
                backgroundColor: Color(0xFF182871),
                onTap: () {
                  // Trigger file download
                  downloadFile();
                },
              ),

            ]

        ),
      ),
    );
  }

  void _searchAsset() async {
    final assetId = int.tryParse(_searchController.text);
    if (assetId != null) {
      final asset = await apiServiceSearch.fetchAsset(assetId);
      if (asset != null) {
        showDetailsDialog(context, asset);
      } else {
        // Handle asset not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Asset not found"),
              actions: <Widget>[
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle invalid asset ID
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Please enter a valid asset ID"),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showDetailsDialog(BuildContext context, Asset2 asset) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 300,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text("Details",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Asset ID:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(asset.assetId.toString(),
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(asset.assetName,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                SizedBox(height: 5),
                Text(asset.assetDescription,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Date of Purchase:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.dateOfPurchase ?? 'N/A',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Cost/Value:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.costValue.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Location:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.location, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Warranty:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.warranty.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Status",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(asset.useStatus ? 'In Use' : 'Not In Use',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void downloadFile() async {
    bool success = await ApiServicedownload.downloadFile();
    String? filepath = await ApiServicedownload.getFilePath();
    if (success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('File Downloaded Successfully'),
            content: Text('File saved at: $filepath'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('File Download Failed'),
            content: Text('Failed to download the file.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
