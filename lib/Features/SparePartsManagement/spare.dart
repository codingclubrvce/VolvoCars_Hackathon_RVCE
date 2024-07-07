import 'package:flutter/material.dart';
import 'package:hackathon/Features/SparePartsManagement/api_service_spare_fetch.dart';
import 'package:hackathon/Features/SparePartsManagement/spare_form.dart';
import 'package:hackathon/Features/SparePartsManagement/spare_lower.dart';
import 'package:hackathon/Widgets/AssetAssemblyCard.dart';
import 'package:hackathon/Widgets/Spare_card.dart';

import 'api_service_search_spare.dart';


class Spare extends StatefulWidget {
  Spare({Key? key}) : super(key: key);

  @override
  _SpareState createState() => _SpareState();
}

class _SpareState extends State<Spare> {
  final ApiServiceSpareParts apiService = ApiServiceSpareParts();
  final ApiServiceSearchSparePart apiServiceSearch = ApiServiceSearchSparePart();
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
              child: SpareCard(),
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
                child: SpareLower(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF182871),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SpareForm(),
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
          tooltip: 'Increment',
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SpareForm(),
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
            icon: Icon(Icons.add, color: Colors.white),
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  void _searchAsset() async {
    final assetId = int.tryParse(_searchController.text);
    if (assetId != null) {
      final asset = await apiServiceSearch.fetchSparePart(assetId);
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

  void showDetailsDialog(BuildContext context, SparePart2 sparePart2) {
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
                Center(child: Text("Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Spare ID:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(sparePart2.spareId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(sparePart2.spareName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                SizedBox(height: 5),
                Text(sparePart2.sparePartCost.toString(), style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Vendor info:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart2.vendorInfo?? 'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Replacement asset", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart2.assetToBeReplacedWith.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Issue date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart2.issue, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart2.location, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Unit No.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart2.unitNo.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),

                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Physical verification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart2.physicalVerification.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
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
}
