import 'package:flutter/material.dart';
import 'package:hackathon/Features/Operations/Faliures/api_service_faliures_fetch.dart';

import 'api_service_add_failure.dart';


class FailureForm extends StatefulWidget {
  @override
  _FailureFormState createState() => _FailureFormState();
}

class _FailureFormState extends State<FailureForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productIdController;
  late TextEditingController _timeStartController;
  late TextEditingController _modelController;
  late TextEditingController _workstationController;
  late TextEditingController _idleTimeController;
  bool _isLoading = false;

  @override
  void dispose() {
    _timeStartController.dispose();
    _modelController.dispose();
    _workstationController.dispose();
    _idleTimeController.dispose();
    _productIdController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final failureData = {
        'product_id': int.parse(_productIdController.text),
        'time_start': _timeStartController.text,
        'model': _modelController.text,
        'workstation': _workstationController.text.isNotEmpty ? _workstationController.text : null,
        'idle_time': int.parse(_idleTimeController.text),
      };


      final apiService = ApiServiceAddFailure();
      try {

        bool result = await apiService.addFailure(failureData);
        print("posted:$result");
        if (result) {
          Navigator.of(context).pop(); // Close the form dialog
          final apiServiceAssets = ApiServiceFailures();
          apiServiceAssets.fetchFailures(); // Refresh the asset list
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
              TextFormField(
                controller: _productIdController,
                decoration: InputDecoration(
                  labelText: 'Product ID',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _timeStartController,
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter start time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _workstationController,
                decoration: InputDecoration(
                  labelText: 'Workstation',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                // No validator needed for optional field
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _idleTimeController,
                decoration: InputDecoration(
                  labelText: 'Idle Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter idle time';
                  }
                  return null;
                },
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
