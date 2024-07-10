import 'package:flutter/material.dart';


import 'api_service_delete.dart';
import 'api_service_edit_breakdowns.dart';
import 'api_service_fetch_breakdown.dart';

class BreakdownLower extends StatefulWidget {
  const BreakdownLower({Key? key}) : super(key: key);

  @override
  _BreakdownLowerState createState() => _BreakdownLowerState();
}

class _BreakdownLowerState extends State<BreakdownLower> {
  late Future<List<Breakdown>> _futureAssets;
  final ApiServiceBreakdowns apiService = ApiServiceBreakdowns();

  @override
  void initState() {
    super.initState();
    _futureAssets = apiService.fetchBreakdowns();
  }

  Future<void> _refreshBreakdowns() async {
    setState(() {
      _futureAssets = apiService.fetchBreakdowns();
    });
  }

  Future<void> _deleteAsset(int assetId) async {
    try {
      bool success = await ApiServiceDeleteBreakdown().deleteBreakdown(assetId);
      if (success) {
        _refreshBreakdowns();
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
        onRefresh: _refreshBreakdowns,
        child: FutureBuilder<List<Breakdown>>(
          future: _futureAssets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No assets found'));
            } else {
              List<Breakdown> assets = snapshot.data!;
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
                onPressed: _refreshBreakdowns,
                icon: Icon(Icons.refresh, color: Colors.white),
              ),
              _buildHeaderItem("ID"),
              _buildHeaderItem("Start Time"),
              _buildHeaderItem("Model"),
              _buildHeaderItem("Workstation"),
              _buildHeaderItem("Offline Time"),
              _buildHeaderItem("Breakdown Reason"),
              SizedBox(width: 100,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem(String text) {
    return SizedBox(
      width: 120,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildAssetRow(Breakdown breakdown, BuildContext context) {
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
              _buildAssetItem(breakdown.assetId.toString(), context, breakdown),
              _buildAssetItem(breakdown.assetName, context, breakdown),
              _buildAssetItem(breakdown.assetDescription, context, breakdown),
              _buildAssetItem(breakdown.workstation ?? 'N/A', context, breakdown),
              _buildAssetItem(breakdown.lastTask, context, breakdown),
              _buildAssetItem(breakdown.lastServiceDate.toString(), context, breakdown),
              _buildAssetItem(breakdown.breakdownReason, context, breakdown),
              _buildAssetItem(breakdown.offlineTime, context, breakdown),
              IconButton(
                onPressed: () {
                  showEditDialog(context, breakdown);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDeleteDialog(context, breakdown);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetItem(String text, BuildContext context, Breakdown breakdown) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, breakdown);
      },
      child: SizedBox(
        width: 120,
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

  void showDeleteDialog(BuildContext context, Breakdown breakdown) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 150,
            child: Column(
              children: [
                Text("Do you wish to delete this row?"),
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    _deleteAsset(breakdown.assetId);
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
      },
    );
  }

  void showDetailsDialog(BuildContext context, Breakdown breakdown) {
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
                    Text("Asset ID:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.assetId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Asset Name:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.assetName, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Asset Description:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.assetDescription, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Workstation:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.workstation ?? 'N/A', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Last Task:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.lastTask, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Last Service Date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.lastServiceDate.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Breakdown Reason:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.breakdownReason, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Offline Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(breakdown.offlineTime, style: TextStyle(fontSize: 18)),
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

  void showEditDialog(BuildContext context, Breakdown breakdown) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _assetid = TextEditingController(text: breakdown.assetId.toString());
    final TextEditingController _assetname = TextEditingController(text: breakdown.assetName);
    final TextEditingController _assetdescription = TextEditingController(text: breakdown.assetDescription ?? '');
    final TextEditingController _workstation = TextEditingController(text: breakdown.workstation);
    final TextEditingController _lasttask = TextEditingController(text: breakdown.lastTask);
    final TextEditingController _lastDate = TextEditingController(text: breakdown.lastTask);
    final TextEditingController _reason = TextEditingController(text: breakdown.breakdownReason);
    final TextEditingController _offline = TextEditingController(text: breakdown.offlineTime);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        // bool _isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Edit Breakdown'),
            // content: _isLoading
            //     ? CircularProgressIndicator()
               content : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _assetid,
                      decoration: InputDecoration(labelText: 'Start Time'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start time';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _assetname,
                      decoration: InputDecoration(labelText: 'Model'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter model';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _assetdescription,
                      decoration: InputDecoration(labelText: 'Workstation'),
                      // No validator needed for optional field
                    ),
                    TextFormField(
                      controller: _workstation,
                      decoration: InputDecoration(labelText: 'Offline Time'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter offline time';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lasttask,
                      decoration: InputDecoration(labelText: 'Breakdown Reason'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter breakdown reason';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastDate,
                      decoration: InputDecoration(labelText: 'Breakdown Reason'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter breakdown reason';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _reason,
                      decoration: InputDecoration(labelText: 'Breakdown Reason'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter breakdown reason';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _offline,
                      decoration: InputDecoration(labelText: 'Breakdown Reason'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter breakdown reason';
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
                    // setState(() {
                    //   _isLoading = true;
                    // });

                    ApiServiceEditBreakdown apiServiceEditBreakdown = ApiServiceEditBreakdown();
                    bool success = await apiServiceEditBreakdown.editBreakdown({
                      'asset id': _assetid,
                      'asset name': _assetname.text,
                      'asset description': _assetdescription.text,
                      'workstation': _workstation.text,
                      'last task': _lasttask.text,
                      'last service date': _lastDate.text,
                      'breakdown reason': _reason.text,
                      'Offline time': _offline.text,
                    });

                    // setState(() {
                    //   _isLoading = false;
                    // });

                    if (success) {
                      _refreshBreakdowns(); // Refresh the list after editing
                      Navigator.of(context).pop();
                    } else {
                      // Show error message
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
