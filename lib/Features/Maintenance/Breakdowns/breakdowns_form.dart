import 'package:flutter/material.dart';
import 'package:hackathon/Features/Maintenance/Breakdowns/api_service_add_breakdown.dart';
import 'package:hackathon/Features/Maintenance/Breakdowns/api_service_fetch_breakdown.dart';

class BreakdownForm extends StatefulWidget {
  @override
  _BreakdownFormState createState() => _BreakdownFormState();
}

class _BreakdownFormState extends State<BreakdownForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _assetIdController;
  late TextEditingController _assetNameController;
  late TextEditingController _assetDescriptionController;
  late TextEditingController _workstationController;
  late TextEditingController _lastTaskController;
  late TextEditingController _lastServiceDateController;
  late TextEditingController _breakdownReasonController;
  late TextEditingController _offlineTimeController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _assetIdController = TextEditingController();
    _assetNameController = TextEditingController();
    _assetDescriptionController = TextEditingController();
    _workstationController = TextEditingController();
    _lastTaskController = TextEditingController();
    _lastServiceDateController = TextEditingController();
    _breakdownReasonController = TextEditingController();
    _offlineTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _assetIdController.dispose();
    _assetNameController.dispose();
    _assetDescriptionController.dispose();
    _workstationController.dispose();
    _lastTaskController.dispose();
    _lastServiceDateController.dispose();
    _breakdownReasonController.dispose();
    _offlineTimeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final breakdownData = {
        'asset_id': int.parse(_assetIdController.text),
        'asset_name': _assetNameController.text,
        'asset_description': _assetDescriptionController.text,
        'workstation': _workstationController.text,
        'last_task': _lastTaskController.text,
        'last_service_date': _lastServiceDateController.text,
        'breakdown_reason': _breakdownReasonController.text,
        'offline_time': _offlineTimeController.text,
      };

      final apiService = ApiServiceAddBreakdown(); // Update as per your project
      try {
        setState(() {
          _isLoading = true;
        });
        bool result = await apiService.addBreakdown(breakdownData);
        print("posted:$result");
        if (result) {
          Navigator.of(context).pop(); // Close the form dialog
          final ApiServiceBreakdowns apiServiceBreakdowns = ApiServiceBreakdowns(); // Update as per your project
          apiServiceBreakdowns.fetchBreakdowns(); // Refresh the asset list
        } else {
          print('Add failed');
        }
      } catch (e) {
        print('Error: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
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
                controller: _assetIdController,
                decoration: InputDecoration(
                  labelText: 'Asset ID',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Asset ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _assetNameController,
                decoration: InputDecoration(
                  labelText: 'Asset Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Asset Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _assetDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Asset Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Asset Description';
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
                validator: (value) {
                  // No validation needed for optional field
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _lastTaskController,
                decoration: InputDecoration(
                  labelText: 'Last Task',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Last Task';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _lastServiceDateController,
                decoration: InputDecoration(
                  labelText: 'Last Service Date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Last Service Date';
                  }
                  // Additional validation for date format can be added here
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _breakdownReasonController,
                decoration: InputDecoration(
                  labelText: 'Breakdown Reason',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Breakdown Reason';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _offlineTimeController,
                decoration: InputDecoration(
                  labelText: 'Offline Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Offline Time';
                  }
                  // Additional validation for time format can be added here
                  return null;
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
