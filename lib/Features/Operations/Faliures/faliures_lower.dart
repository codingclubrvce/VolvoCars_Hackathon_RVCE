import 'package:flutter/material.dart';
import 'package:hackathon/Features/Operations/Faliures/api_service_faliures_fetch.dart';

import 'api_service_delete_failure.dart';
import 'api_service_edit_failure.dart';


class FailureLower extends StatefulWidget {
  const FailureLower({Key? key}) : super(key: key);

  @override
  _FailureLowerState createState() => _FailureLowerState();
}

class _FailureLowerState extends State<FailureLower> {
  late Future<List<Failure>> _futureAssets;
  final ApiServiceFailures apiService = ApiServiceFailures();

  @override
  void initState() {
    super.initState();
    _futureAssets = apiService.fetchFailures();
  }

  Future<void> _refreshFailures() async {
    setState(() {
      _futureAssets = apiService.fetchFailures();
    });
  }
  Future<void> _deleteAsset(int productId) async {
    try {
      bool success = await ApiServiceDeleteFailure().deleteFailure(productId);// failure se replace
      if (success) {
        _refreshFailures();
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
        onRefresh: _refreshFailures,
        child: FutureBuilder<List<Failure>>(
          future: _futureAssets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No assets found'));
            } else {
              List<Failure> assets = snapshot.data!;
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
                onPressed: _refreshFailures,
                icon: Icon(Icons.refresh, color: Colors.white),
              ),
              _buildHeaderItem("ID"),
              _buildHeaderItem("Start Time"),
              _buildHeaderItem("model"),
              _buildHeaderItem("workstation"),
              _buildHeaderItem("Idle Time"),
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

  Widget _buildAssetRow(Failure failure, BuildContext context) {
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
              _buildAssetItem(failure.productId.toString(), context, failure),
              _buildAssetItem(failure.timeStart, context, failure),
              _buildAssetItem(failure.model, context, failure),
              _buildAssetItem(failure.workstation ?? 'N/A', context, failure),
              _buildAssetItem(failure.idleTime.toString(), context, failure),
              // _buildAssetItem(asset.location, context, asset),
              // _buildAssetItem(asset.warranty.toString(), context, asset),
              // _buildAssetItem(asset.useStatus ? 'In Use' : 'Not In Use', context, asset),
              IconButton(
                onPressed: () {
                  showEditDialog(context, failure);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(onPressed: (){
                showDeleteDialog(context,failure);
              }, icon: Icon(Icons.delete)),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetItem(String text, BuildContext context, Failure failure) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, failure);
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
  void showDeleteDialog(BuildContext context,Failure failure)
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
                      _deleteAsset(failure.productId);
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

  void showDetailsDialog(BuildContext context, Failure failure) {
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
                    Text(failure.productId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),

                Divider(),
                Row(
                  children: [
                    Text("Start Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(failure.timeStart, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),


                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Model", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(failure.model, style: TextStyle(fontSize: 15)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Workstation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(failure.workstation ?? 'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Idle Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(failure.idleTime.toString(), style: TextStyle(fontSize: 13)),
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

  void showEditDialog(BuildContext context, Failure failure) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _timeStartController = TextEditingController(text: failure.timeStart);
    final TextEditingController _modelController = TextEditingController(text: failure.model);
    final TextEditingController _workstationController = TextEditingController(text: failure.workstation ?? '');
    final TextEditingController _idleTimeController = TextEditingController(text: failure.idleTime.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Edit Failure'),
            content: _isLoading
                ? CircularProgressIndicator()
                : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _timeStartController,
                      decoration: InputDecoration(labelText: 'Start Time'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start time';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _modelController,
                      decoration: InputDecoration(labelText: 'Model'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter model';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _workstationController,
                      decoration: InputDecoration(labelText: 'Workstation'),
                      // No validator needed for optional field
                    ),
                    TextFormField(
                      controller: _idleTimeController,
                      decoration: InputDecoration(labelText: 'Idle Time'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter idle time';
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
                onPressed: _isLoading
                    ? null
                    : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                    ApiServiceEditFailure apiServiceEditFailure = ApiServiceEditFailure();
                    bool success = await apiServiceEditFailure.editFailure({
                      'product_id': failure.productId,
                      'time_start': _timeStartController.text,
                      'model': _modelController.text,
                      'workstation': _workstationController.text.isEmpty ? null : _workstationController.text,
                      'idle_time': int.parse(_idleTimeController.text),
                    });

                    setState(() {
                      _isLoading = false;
                    });

                    if (success) {
                      _refreshFailures(); // Refresh the list after editing
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
