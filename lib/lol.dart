import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> getAccessToken() async {
    // Your client ID and client secret obtained from Google Cloud Console
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "volvo-358a4",
      "private_key_id": "251e462aeab823b54572b1210f865969cd0d7e5e",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8a+jRLkeeualu\nutG7pQtlEQlp98H3Xtqq/HmBHkK/4yQ1ksLVzJCGvlAIlpDs+hoW+v1K2UNmil9r\n36h4T46TT9fe55cnet7syor3tFei7D7gCPwfcBwhsORqqnLm/rwuts+dNhGYQ6ZC\n97x5+wNZis4NXKzPwDLLVGCFmeLTjvmXuOzncZnIUjPVZxS9EdIoT+fp2ThKRMon\nYuZ7cPuMDaP4J4wqduLQI1/il7Asv8m3OuOiKZU1FX+UdTfFzFZc8cSOduyYkarD\nEl6gCEZobbl4Lv/y2hVG6wK4AHAHoaMRer/BEUd1i0eLWQhonx8n7n6Az7KrZWWw\nG4jex8F7AgMBAAECggEACC9r4sJu7A9Gs/+7orotv4s47HiN3ZAqUak8IgbNgYZ9\niTJB8oW7dY8I7QaVbyYCQiNPI5RCoE68jHQf3nIeUHn0d8N5xoZI7uJxnQchk3tN\n0++v/DGjlzcXBSc4bJ5+UE0ywbKamxG9REV805O69oXYI65192RzEHAu7T7dIrGN\nLCJAMmm5cXbikSeWX4/+XXMYeBJHwPziZUd6MAxpyRIbppHw0hr60Kga0BIDh8DP\n+EuGR9wReTvWt7zqr2dP94/jtxf/cvdlkkP+Z+0fAHedWlXOt1a6kJuTxA9P9YP9\n2p6gujtzHSkTZ7P/I4OGFXWxBDwZLASVAl8Ne1DcQQKBgQDyCdmW5j+fl42jeRRF\nyBzLGBAuje3S2rbsXhyHTZ8DYs/6CGFEZGOfcDGlNrGXVuBkqBdzP2wdJ8ZQrZrU\n6WYJpdOSmHJVm+/AMdXOoWjX7fQi0dNqGBPrUi2iIr1PICNtFcmOWf76Ug8tznJn\nYn2nsgie4HwdgBBrLE2p8y0xYQKBgQDHSk4WMTga0G9RUt45xHUrQtT/TRr6rXN8\nTJGAlOdLkAcypIyEYAjt+/YXz+HRGdIckxhqxrLrHxXRsZBYOL8ySlQfK12motEq\nWbSiWGeZIxujmktOLQKZJ+QZT0xMcM3Yl5GZoa7RzfRckVgIBoVQKtXqPk3hlxPI\n4ja61F+0WwKBgQC5upk/1DtqSa+ki9rkmWSO7E4uiza+IJtR0f3uTcABpyeU5C1P\ngAF6bWuLLeclDMNwOhSUmUxrKwRhEHbJfriQGrG5wkWqL9jQEO3Se8WqPKyks4KZ\n3RQb9ZmS2zmNqEnHAXsDQ0gH6kQ/kDX143ws3M8Eq5pSQN1YgEywZyx8wQKBgQCV\nKhOqXqqsv0giqZD10gsVF0/Py0mfSYZACht6D3nTv/jzOeCHEE5+unFnP0y5Msdm\nZd8HxLOUcs7lBi+RKOBK5wFx1wagvAss1Ln0LZFVOMbuPIWS/PON6SK8ovLr4B7i\nuAfd4vuzw6DcTFmEoETWTUmRq5KlgGvplw/55Q3BMwKBgEEspDzWfvyOqS7f1c0O\nypB5miZxkPzKxB6tN5EIcTq03mSnJh+b3oAL8bWItynFgKl2R05D4GU0/zZbltB9\nWEhJXFSSjz92abj6ZoC/RSx2aku5en67/fSw+tovgU4IBCVvDN0uXWfv35fv5Ire\nFt4oQPNdihN8cfdoWeuVhaFR\n-----END PRIVATE KEY-----\n",
      "client_email": "volvo-791@volvo-358a4.iam.gserviceaccount.com",
      "client_id": "114179448239269537293",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/volvo-791%40volvo-358a4.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
    ;

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client
    );

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;

  }

  Future<void> sendFCMMessage(String text) async {
    final String serverKey = await getAccessToken() ; // Your FCM server key
    final String fcmEndpoint = 'https://fcm.googleapis.com/v1/projects/volvo-358a4/messages:send';
    final  currentFCMToken = 'fim3CjExRVmDGOQz85oKS6:APA91bEfeMrcr994Q0VGEY4K17pAe44g9BYw_IpOiByZqNjAKuRV8BpZhdMd-MBVSSL24Uz_3FR3WevQaqvt5rPS-XmYsTyMxyI1gsbpe-Di4TvDEt98T1kaZZol8tOGajseH2lNRGgm';
    // await FirebaseMessaging.instance.getToken();
    // print(currentFCMToken);
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'token': currentFCMToken, // Token of the device you want to send the message to
        'notification': {
          'body': text,
          'title': 'Volvo Asset Manager'
        },
        'data': {
          'current_user_fcm_token': currentFCMToken, // Include the current user's FCM token in data payload
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }



  // void _handleSignOut(BuildContext context) async {
  //   try {
  //     FirebaseAuth.instance.signOut();
  //     await _googleSignIn.signOut();
  //     // After sign out, navigate to the login or home screen
  //     Navigator.push(context,MaterialPageRoute(builder: (context)=>  LoginPage())); // Replace '/login' with your desired route
  //   } catch (error) {
  //     print("Error signing out: $error");
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),automaticallyImplyLeading: false, centerTitle: true,titleTextStyle: TextStyle(
          color: Colors.lightBlue[200],
          fontWeight: FontWeight.w800,
          fontSize: 28
      ),),
      body:Container(
        margin: EdgeInsets.only(left: 160),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue[100]),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text("send"),
            ),
            ElevatedButton(
              onPressed: () { },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue[100]),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text("LogOut"),
            )],
        ),
      ) ,
    );
  }
}