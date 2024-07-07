import 'package:flutter/material.dart';
import 'package:hackathon/Dashboard/dashboard.dart';
import 'package:hackathon/Features/Features%20list.dart';

import 'Dashboard/bargraph.dart';
import 'Dashboard/circularindicator.dart';
import 'Features/Asset Inventory/AssetAssembly.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: RouteGenerator.getRoute,
      home: Dashboard()
    );
  }
}