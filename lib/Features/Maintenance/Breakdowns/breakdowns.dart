import 'package:flutter/material.dart';
import 'package:hackathon/Features/Maintenance/Breakdowns/api_service_fetch_breakdown.dart';
import 'package:hackathon/Features/Maintenance/Breakdowns/api_service_search_breakdown.dart';
import 'package:hackathon/Features/Maintenance/Breakdowns/breakdowns_form.dart';
import 'package:hackathon/Features/Maintenance/Breakdowns/breakdowns_lower.dart';
import 'package:hackathon/Features/Operations/Faliures/api_service_faliures_fetch.dart';
import 'package:hackathon/Widgets/AssetAssemblyCard.dart';
import 'package:hackathon/Widgets/breakdown_card.dart';

import '../../../Widgets/Faliures_card.dart';


class Breakdowns extends StatefulWidget {
  Breakdowns({Key? key}) : super(key: key);

  @override
  _BreakdownsState createState() => _BreakdownsState();
}

class _BreakdownsState extends State<Breakdowns> {
  final ApiServiceBreakdowns apiService = ApiServiceBreakdowns();
  final ApiServiceSearchBreakdown apiServiceSearch = ApiServiceSearchBreakdown();
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
              child: MaintenanceCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Find Product by ID',
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
                child: BreakdownLower(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF182871),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: BreakdownForm(),
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
                    content: BreakdownForm(),
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
    final productId = int.tryParse(_searchController.text);
    if (productId != null) {
      final asset = await apiServiceSearch.searchBreakdown(productId);
      if (asset != null) {
        showDetailsDialog(context, asset);
      } else {
        // Handle asset not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Product not found"),
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
            content: Text("Please enter a valid product ID"),
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

  void showDetailsDialog(BuildContext context, Breakdown2 breakdown2) {
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
                    Text("Product ID:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown2.assetId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),

                Divider(),
                Row(
                  children: [
                    Text("Start Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.assetName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),


                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Model", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.assetDescription, style: TextStyle(fontSize: 15)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Workstation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.workstation ?? 'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Idle Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.lastTask.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    Text("Idle Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.lastServiceDate.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    Text("Idle Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.breakdownReason.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    Text("Idle Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(breakdown2.offlineTime.toString(), style: TextStyle(fontSize: 13)),
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
}
