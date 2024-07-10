import 'package:flutter/material.dart';
import 'api_service_add_product.dart';

class OperationsForm extends StatefulWidget {
  @override
  _OperationsFormState createState() => _OperationsFormState();
}

class _OperationsFormState extends State<OperationsForm> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _modelNameController = TextEditingController();
  final _assemblyStartTimeController = TextEditingController();
  final _assemblyEndTimeController = TextEditingController();
  final _totalStipulatedTimeController = TextEditingController();
  final _numberOfAndonsRaisedController = TextEditingController();
  final _andonStatusController = TextEditingController();
  final _andonTimeStartController = TextEditingController();
  final _andonTimeEndController = TextEditingController();

  @override
  void dispose() {
    _productIdController.dispose();
    _modelNameController.dispose();
    _assemblyStartTimeController.dispose();
    _assemblyEndTimeController.dispose();
    _totalStipulatedTimeController.dispose();
    _numberOfAndonsRaisedController.dispose();
    _andonStatusController.dispose();
    _andonTimeStartController.dispose();
    _andonTimeEndController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final productData = {
        "product_id": int.parse(_productIdController.text),
        "model_name": _modelNameController.text,
        "assembly_start_time": _assemblyStartTimeController.text,
        "assembly_end_time": _assemblyEndTimeController.text,
        "total_stipulated_time": _totalStipulatedTimeController.text,
        "number_of_andons_raised": int.parse(_numberOfAndonsRaisedController.text),
        "andon_status": _andonStatusController.text.toLowerCase() == 'true',
        "andon_time_start": _andonTimeStartController.text,
        "andon_time_end": _andonTimeEndController.text,
      };

      final apiService = ApiServiceAddProduct();
      try {
        bool result = await apiService.addProduct(productData);
        print("posted:$result");
        if (result) {
          Navigator.of(context).pop(); // Close the form dialog
          // Perform any additional actions like refreshing the list
        } else {
          print('Add failed');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _productIdController,
                      decoration: InputDecoration(
                        labelText: 'Product ID',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _numberOfAndonsRaisedController,
                      decoration: InputDecoration(
                        labelText: 'Andons Raised',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _modelNameController,
                decoration: InputDecoration(
                  labelText: 'Model Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _assemblyStartTimeController,
                decoration: InputDecoration(
                  labelText: 'Assembly Start Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _assemblyEndTimeController,
                decoration: InputDecoration(
                  labelText: 'Assembly End Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _totalStipulatedTimeController,
                decoration: InputDecoration(
                  labelText: 'Total Stipulated Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _andonTimeStartController,
                decoration: InputDecoration(
                  labelText: 'Andon Time Start',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _andonTimeEndController,
                decoration: InputDecoration(
                  labelText: 'Andon Time End',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<bool>(
                value: null,
                onChanged: (bool? newValue) {
                  _andonStatusController.text = newValue.toString();
                },
                decoration: InputDecoration(labelText: 'Andon Status'),
                items: [
                  DropdownMenuItem(value: true, child: Text('True')),
                  DropdownMenuItem(value: false, child: Text('False')),
                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
