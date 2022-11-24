import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:safetech_app/models/user.dart';
import 'package:safetech_app/pages/authentication/register.dart';
import 'package:safetech_app/pages/home_user.dart';
import 'dart:convert';

import 'package:safetech_app/utils/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../utils/http_helper.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  HttpHelper httpHelper = HttpHelper();

  final myEmail = TextEditingController();
  final myPassword = TextEditingController();

  late bool _passwordVisible;

  //User login credentials
  @override
  void initState() {
    _passwordVisible = false;
    myEmail.text = "admin@gmail.com";
    myPassword.text = "password";
    super.initState();
  }

  Future<User?> getUserByEmail(email) async {
    var user = await httpHelper.fetchByUserEmail(email);
    return user;
  }

  void generalLogin(String email, String password) async {
    try {
      User? user = await getUserByEmail(email);
      if (user != null) {
        saveUserData(user.id);
        if (user.password == password) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home_user()));
        }
      }
    } catch (e) {
      print("Error logging the user");
    }
  }

  Future<void> saveUserData(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = await httpHelper.fetchUserById(id);
    String user1 = jsonEncode(user);
    prefs.setString('user', user1);
    await prefs.setInt('id', id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://media.discordapp.net/attachments/729537977092407390/1045150784289001472/image2.jpg?width=890&height=890',
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.33
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text('SafeTech',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(115, 103, 240, 94),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Ingresa tu email y contraseña',
                  style: TextStyle(fontSize: 14, height: 0.5),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: myEmail,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: myPassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 159, 68, 100),
                ),
                child: Text('Iniciar sesión',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () => generalLogin(myEmail.text, myPassword.text),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tiene cuenta?'),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Color.fromRGBO(255, 159, 68, 100),
                    ),
                    child: Text('Regístrate aquí'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
