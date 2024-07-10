import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../Dashboard/dashboard.dart';

const users =  {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'meow';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: const AssetImage('assets/images/BHOLBHOLOGO.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
      primaryColor: Color(0xff182871),
      accentColor: Color(0xff182871),
      errorColor: Colors.deepOrange,
      titleStyle: const TextStyle(
        color: Colors.greenAccent,
        fontFamily: 'Quicksand',
        letterSpacing: 4,
      ),)
    );
  }
}