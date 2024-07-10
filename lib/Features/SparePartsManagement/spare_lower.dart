import 'package:flutter/material.dart';
import 'package:hackathon/Features/SparePartsManagement/api_service_spare_fetch.dart';

import '../Asset Inventory/api_service_asset_delete.dart';
import 'api_service_edit_spare.dart';


class SpareLower extends StatefulWidget {
  const SpareLower({Key? key}) : super(key: key);

  @override
  _SpareLowerState createState() => _SpareLowerState();
}

class _SpareLowerState extends State<SpareLower> {
  late Future<List<SparePart>> _futureAssets;
  final ApiServiceSpareParts apiService = ApiServiceSpareParts();

  @override
  void initState() {
    super.initState();
    _futureAssets = apiService.fetchSpareParts();
  }

  Future<void> _refreshAssets() async {
    setState(() {
      _futureAssets = apiService.fetchSpareParts();
    });
  }
  Future<void> _deleteAsset(int assetId) async {
    try {
      bool success = await ApiServiceDeleteAsset().deleteAsset(assetId);
      if (success) {
        _refreshAssets();
        // Refresh the list after deleting
      } else {
        // Handle deletion failure if needed
      }
    } catch (e) {
      // Handle any API call errors
      print('Error deleting asset: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshAssets,
        child: FutureBuilder<List<SparePart>>(
          future: _futureAssets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No assets found'));
            } else {
              List<SparePart> assets = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderRow(context),
                      ...assets.map((asset) => _buildAssetRow(asset, context)).toList(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0XFF182871),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                onPressed: _refreshAssets,
                icon: Icon(Icons.refresh, color: Colors.white),
              ),
              _buildHeaderItem("ID"),
              _buildHeaderItem("Name"),
              _buildHeaderItem("Cost"),
              _buildHeaderItem("Vendor Info"),
              _buildHeaderItem("Replacement Asset"),
              _buildHeaderItem("Issue"),
              _buildHeaderItem("Location"),
              _buildHeaderItem("Unit no"),
              _buildHeaderItem("Physical Verification"),
              SizedBox(width: 100,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem(String text) {
    return SizedBox(
      width: 100,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildAssetRow(SparePart sparePart, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 50,),
              _buildAssetItem(sparePart.spareId.toString(), context, sparePart),
              _buildAssetItem(sparePart.spareName, context, sparePart),
              _buildAssetItem(sparePart.sparePartCost.toString(), context, sparePart),
              _buildAssetItem(sparePart.vendorInfo ?? 'N/A', context, sparePart),
              _buildAssetItem(sparePart.assetToBeReplacedWith, context, sparePart),
              _buildAssetItem(sparePart.issue, context, sparePart),
              _buildAssetItem(sparePart.location, context, sparePart),
              _buildAssetItem(sparePart.unitNo.toString(), context, sparePart),
              _buildAssetItem(sparePart.physicalVerification.toString(), context, sparePart),

              IconButton(
                onPressed: () {
                  showEditDialog(context, sparePart);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(onPressed: (){
                showDeleteDialog(context,sparePart);
              }, icon: Icon(Icons.delete)),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetItem(String text, BuildContext context, SparePart sparePart) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, sparePart);
      },
      child: SizedBox(
        width: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
  void showDeleteDialog(BuildContext context,SparePart sparePart)
  {
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Text("Do you wish to delete this row?"),
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      _deleteAsset(sparePart.spareId);
                      Navigator.of(context).pop();

                    },
                  ),
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showDetailsDialog(BuildContext context, SparePart sparePart) {
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
                    Text(sparePart.spareId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(sparePart.spareName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                SizedBox(height: 5),
                Text(sparePart.sparePartCost.toString(), style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Vendor info:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart.vendorInfo?? 'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Replacement asset", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart.assetToBeReplacedWith.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Issue date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart.issue, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart.location, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Unit No.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart.unitNo.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),

                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Physical verification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(sparePart.physicalVerification.toString(), style: TextStyle(fontSize: 13)),
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

  void showEditDialog(BuildContext context, SparePart sparePart) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _sparenameController = TextEditingController(text: sparePart.spareName);
    final TextEditingController _sparecostController = TextEditingController(text: sparePart.sparePartCost.toString());
    final TextEditingController _vendorController = TextEditingController(text: sparePart.vendorInfo);
    final TextEditingController _ReplacementController = TextEditingController(text: sparePart.assetToBeReplacedWith);
    final TextEditingController _issueController = TextEditingController(text: sparePart.issue);
    final TextEditingController _LocationController = TextEditingController(text: sparePart.location);
    final TextEditingController _unitController = TextEditingController(text: sparePart.unitNo.toString());
    final TextEditingController _verificationController = TextEditingController(text: sparePart.physicalVerification.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Spare Part'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _sparenameController,
                    decoration: InputDecoration(labelText: 'Spare Part Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter spare part name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _sparecostController,
                    decoration: InputDecoration(labelText: 'Spare Part Cost'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter spare part cost';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _vendorController,
                    decoration: InputDecoration(labelText: 'Vendor Info'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter vendor info';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ReplacementController,
                    decoration: InputDecoration(labelText: 'Asset to be Replaced With'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter asset to be replaced with';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _issueController,
                    decoration: InputDecoration(labelText: 'Issue Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter issue date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _LocationController,
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _unitController,
                    decoration: InputDecoration(labelText: 'Unit Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter unit number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _verificationController,
                    decoration: InputDecoration(labelText: 'Physical Verification'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter whether verified or not';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Edit'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ApiServiceEditSparePart apiServiceEditSparePart = ApiServiceEditSparePart();
                  bool success = await apiServiceEditSparePart.editSparePart({
                    'spare_id': sparePart.spareId,
                    'spare_name': _sparenameController.text,
                    'spare_part_cost': double.parse(_sparecostController.text),
                    'vendor_info': _vendorController.text,
                    'asset_to_be_replaced_with': _ReplacementController.text,
                    'issue': _issueController.text,
                    'location': _LocationController.text,
                    'unitno': int.parse(_unitController.text),
                    'physical_verification': _verificationController.text.toLowerCase() == 'true',
                  });

                  if (success) {
                    _refreshAssets(); // Refresh the list after editing
                    Navigator.of(context).pop();
                  } else {
                    // Show error message
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

}
