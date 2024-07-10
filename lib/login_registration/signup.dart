import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/login_registration/login.dart';
import 'package:http/http.dart' as http;

import '../resources/Strings.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;
  String? registrationMessage; // Variable to store registration message
  bool isLoading = false; // Track loading state

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  Future<void> register(String email, String password) async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      final response = await http.post(
        Uri.parse('http://${Strings.localhost_login}/authentication/register.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          registrationMessage = data['message'];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        });
      } else {
        setState(() {
          registrationMessage = 'Registration failed';
        });
      }
    } catch (e) {
      setState(() {
        registrationMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
      if (registrationMessage != null) {
        // Show dialog if registrationMessage is not null
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Registration Status'),
            content: Text(registrationMessage!),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0XFF182871),

        title: Text("Volvo",style: TextStyle(
            fontSize:18,fontWeight: FontWeight.bold,fontFamily: "Inter"   ,color: Colors.white       //this will be a variable text area, e.g. ffetch from the users name
        ),),



        // titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email Id',
                  fillColor: Colors.redAccent.withOpacity(0.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  fillColor: Colors.redAccent.withOpacity(0.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: isLoading
                    ? null
                    : () {
                  register(emailController.text, passwordController.text);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0XFF182871),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    )
                        : Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
