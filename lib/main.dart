import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hackathon/Dashboard/dashboard.dart';
import 'package:hackathon/Features/Features%20list.dart';
import 'package:hackathon/login_registration/Lgin.dart';
import 'package:hackathon/login_registration/login.dart';

import 'Dashboard/bargraph.dart';
import 'Dashboard/circularindicator.dart';
import 'Features/Asset Inventory/AssetAssembly.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize the plugin
  final InitializationSettings initializationSettings =
  InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),

  );



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: RouteGenerator.getRoute,
      home: LoginScreen()
    );
  }
}