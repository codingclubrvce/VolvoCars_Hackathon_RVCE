import 'package:flutter/material.dart';
import 'package:hackathon/Features/Operations/AA/api_service_delete_product.dart';
import 'package:hackathon/Features/Operations/AA/api_service_fetch_operation.dart';

import 'api_service_edit_product.dart';


class OperationsLower extends StatefulWidget {
  const OperationsLower({Key? key}) : super(key: key);

  @override
  _OperationsLowerState createState() => _OperationsLowerState();
}

class _OperationsLowerState extends State<OperationsLower> {
  late Future<List<ProductAssembly>> _futureAssets;
  final ApiServiceOperationsFetch apiService = ApiServiceOperationsFetch();

  @override
  void initState() {
    super.initState();
    _futureAssets = apiService.fetchAssets();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _futureAssets = apiService.fetchAssets();
    });
  }
  Future<void> _deleteProduct(int productID) async {
    try {
      bool success = await ApiServiceDeleteProduct().deleteProduct(productID);
      if (success) {
        _refreshProducts;
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
        onRefresh: _refreshProducts,
        child: FutureBuilder<List<ProductAssembly>>(
          future: _futureAssets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No assets found'));
            } else {
              List<ProductAssembly> assets = snapshot.data!;
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
                onPressed: _refreshProducts,
                icon: Icon(Icons.refresh, color: Colors.white),
              ),
              _buildHeaderItem("ID"),
              _buildHeaderItem("Name"),
              _buildHeaderItem("Assembly start"),
              SizedBox(width: 10,),
              _buildHeaderItem("Assembly end"),
              _buildHeaderItem("Total time"),
              _buildHeaderItem("Number of Andons"),
              _buildHeaderItem("Status"),
              _buildHeaderItem("Andon Start time"),
              _buildHeaderItem("Andon End time"),

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

  Widget _buildAssetRow(ProductAssembly productAssembly, BuildContext context) {
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
              _buildAssetItem(productAssembly.productId.toString(), context, productAssembly),
              _buildAssetItem(productAssembly.modelName??'N/A', context, productAssembly),
              _buildAssetItem(productAssembly.assemblyStartTime??'N/A', context, productAssembly),
              _buildAssetItem(productAssembly.assemblyEndTime ?? 'N/A', context, productAssembly),
              _buildAssetItem(productAssembly.totalStipulatedTime.toString(), context, productAssembly),
              _buildAssetItem(productAssembly.numberOfAndonsRaised.toString(), context, productAssembly),
              _buildAssetItem(productAssembly.andonStatus.toString(), context, productAssembly),
              _buildAssetItem(productAssembly.andonTimeStart??'N/A', context, productAssembly),
              _buildAssetItem(productAssembly.andonTimeEnd??'N/A', context, productAssembly),
              IconButton(
                onPressed: () {
                  showEditDialog(context, productAssembly);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(onPressed: (){
                showDeleteDialog(context,productAssembly);
              }, icon: Icon(Icons.delete)),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetItem(String text, BuildContext context, ProductAssembly productAssembly) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, productAssembly);
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
  void showDeleteDialog(BuildContext context,ProductAssembly productAssembly)
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
                      _deleteProduct(productAssembly.productId);
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

  void showDetailsDialog(BuildContext context, ProductAssembly productAssembly) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 350,
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Product ID:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 5),
                    Text(productAssembly.productId.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Text(productAssembly.modelName??'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),

                SizedBox(height: 10),
                Divider(),
                Row(
                  children: [
                    Text("Assembly Start Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.assemblyStartTime??'N/A', style: TextStyle(fontSize: 15)),
                    SizedBox(width: 7),
                  ],
                ),
                Row(
                  children: [

                    Text("Assembly End Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.assemblyStartTime??'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Total Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.totalStipulatedTime.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Number of Andons", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.numberOfAndonsRaised.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Status of Andon", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.andonStatus.toString(), style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Andon start time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.andonTimeStart??'N/A', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(width: 7),
                Row(
                  children: [
                    Text("Andon End time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(width: 7),
                    Text(productAssembly.andonTimeEnd??'N/A', style: TextStyle(fontSize: 13)),
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

  void showEditDialog(BuildContext context, ProductAssembly productAssembly) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController(text: productAssembly.modelName);
    final TextEditingController _startTimeController = TextEditingController(text: productAssembly.assemblyStartTime);
    final TextEditingController _EndTimeController = TextEditingController(text: productAssembly.assemblyEndTime);
    final TextEditingController _totalTimeController = TextEditingController(text: productAssembly.totalStipulatedTime.toString());
    final TextEditingController _numberAndonsController = TextEditingController(text: productAssembly.numberOfAndonsRaised.toString());
    final TextEditingController _andonStatusController = TextEditingController(text: productAssembly.andonStatus.toString());
    final TextEditingController _andonStartController = TextEditingController(text: productAssembly.andonTimeStart.toString());
    final TextEditingController _andonEndController = TextEditingController(text: productAssembly.andonTimeEnd.toString());


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _startTimeController,
                    decoration: InputDecoration(labelText: 'Product Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _EndTimeController,
                    decoration: InputDecoration(labelText: 'assembly start time'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter start time';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _totalTimeController,
                    decoration: InputDecoration(labelText: 'Cost Value'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cost value';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _numberAndonsController,
                    decoration: InputDecoration(labelText: 'Number of Andons'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of andons';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _andonStatusController,
                    decoration: InputDecoration(labelText: 'Andon Status'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter andon status';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _andonStartController,
                    decoration: InputDecoration(labelText: 'Andon start time'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Andon start time';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _andonEndController,
                    decoration: InputDecoration(labelText: 'Andon End Time'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Andon End Time';
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
                  ApiServiceEditProduct apiServiceEditProduct = ApiServiceEditProduct();
                  bool success = await apiServiceEditProduct.editProduct({
                    'product_id': productAssembly.productId,
                    'model_name': _nameController.text,
                    'assembly_start_time': _startTimeController.text,
                    'assembly_end_time': _EndTimeController.text,
                    'total_stipulated_time': _totalTimeController.text,
                    'number_of_andons_raised': int.parse(_numberAndonsController.text),
                    'andon_status': _andonStatusController.text.toLowerCase() == 'true',
                    'andon_time_start': _andonStartController.text,
                    'andon_time_end': _andonEndController.text,
                  });

                  if (success) {
                    _refreshProducts; // Refresh the list after editing
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
