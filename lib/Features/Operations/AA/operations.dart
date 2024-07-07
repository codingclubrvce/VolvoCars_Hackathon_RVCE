import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/Features/Operations/AA/api_service_fetch_operation.dart';
import 'package:hackathon/Features/Operations/AA/operations_form.dart';
import 'package:hackathon/Features/Operations/AA/operations_lower.dart';
import 'package:hackathon/Widgets/AssetAssemblyCard.dart';
import 'package:hackathon/Widgets/Operations_card.dart';
import 'api_service_releaseAndon.dart';
import 'api_service_reportAndon.dart';
import 'api_service_search_operations.dart';

class Operations extends StatefulWidget {
  Operations({Key? key}) : super(key: key);

  @override
  _AssetAssemblyState createState() => _AssetAssemblyState();
}

class _AssetAssemblyState extends State<Operations> {
  final ApiServiceOperationsFetch apiService = ApiServiceOperationsFetch();
  final ApiServiceSearchProduct apiServiceSearch = ApiServiceSearchProduct();
  final ApiServiceReportAndon apiServiceReportAndon = ApiServiceReportAndon();
  final ApiServiceReleaseAndon apiServiceReleaseAndon = ApiServiceReleaseAndon(); // Create an instance
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
            OperationsCard(),
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 17.0, top: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      _showAndonDialog(context, isRelease: false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFF0000),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/images/announcement-icon.svg',
                              color: Colors.white,
                              width: 60,
                              height: 60,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "REPORT ANDON",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 0),
                  child: GestureDetector(
                    onTap: () {
                      _showAndonDialog(context, isRelease: true);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/images/mechanic-icon.svg',
                              color: Colors.black,
                              width: 60,
                              height: 60,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "RELEASE ANDON",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: OperationsLower(),
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
                  content: OperationsForm(),
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
                    content: OperationsForm(),
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

  void _showAndonDialog(BuildContext context, {required bool isRelease}) {
    final TextEditingController _productIdController = TextEditingController();
    final String title = isRelease ? "Release Andon" : "Report Andon";
    final Function action = isRelease ? apiServiceReleaseAndon.releaseAndon : apiServiceReportAndon.reportAndon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _productIdController,
            decoration: InputDecoration(
              labelText: "Enter Product ID",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () async {
                final productId = int.tryParse(_productIdController.text);
                if (productId != null) {
                  final success = await action(productId);
                  Navigator.of(context).pop();
                  _showResponseDialog(context, success);
                } else {
                  // Handle invalid product ID
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
              },
            ),
          ],
        );
      },
    );
  }

  void _showResponseDialog(BuildContext context, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(success ? "Andon action succeeded!" : "Failed to perform Andon action"),
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

  void _searchAsset() async {
    final productID = int.tryParse(_searchController.text);
    if (productID != null) {
      final product = await apiServiceSearch.fetchProduct(productID);
      if (product != null) {
        showDetailsDialog(context, product);
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
      // Handle invalid product ID
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

  void showDetailsDialog(BuildContext context, ProductAssembly2 productAssembly2) {
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
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Asset ID:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(productAssembly2.productId.toString(),
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(productAssembly2.modelName ?? 'N/A',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                SizedBox(height: 5),
                Text(productAssembly2.assemblyStartTime ?? 'N/A',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Date of Purchase:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly2.assemblyStartTime ?? 'N/A',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Cost/Value:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly2.totalStipulatedTime.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Location:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly2.numberOfAndonsRaised.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Warranty:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly2.andonStatus.toString(),
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Status",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly2.andonTimeStart ?? 'N/A',
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Status",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly2.andonTimeEnd ?? 'N/A',
                        style: TextStyle(fontSize: 13)),
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
