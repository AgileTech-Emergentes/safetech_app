import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/pages/authentication/login.dart';
import 'package:safetech_app/utils/http_helper.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();

  static const String routeName = "/register";
}

class _RegisterState extends State<Register> {
  HttpHelper httpHelper = HttpHelper();
  DateTime selectedDate = DateTime.now();

  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerDni = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerProfilePictureUrl =
      TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerBirthdayDate = TextEditingController();

  late bool _passwordVisible;

  @override
  void initState() {
    httpHelper = HttpHelper();
    _passwordVisible = false;
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controllerBirthdayDate.text = selectedDate.toString().substring(0, 10);
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text('Registro de usuario',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerFirstName,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerLastName,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerDni,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  labelText: 'DNI',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerPassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    isDense: true,
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        })),
              ),
              SizedBox(height: 16),
              
              TextField(
                controller: controllerAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerPhone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controllerBirthdayDate,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    labelText: 'Fecha de nacimiento',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          _selectDate(context);
                        })),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  child: Text('Registrarse',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () async {
                    String firstName = controllerFirstName.text;
                    String lastName = controllerLastName.text;
                    String dni = controllerDni.text;
                    String email = controllerEmail.text;
                    String password = controllerPassword.text;
                    String profilePictureUrl =
                        "https://img2.freepng.es/20180714/ro/kisspng-computer-icons-user-membership-vector-5b498fc76f2a07.4607730515315475914553.jpg";
                    String address = controllerAddress.text;
                    String phone = controllerPhone.text;
                    String birthdayDate = controllerBirthdayDate.text;
                    await httpHelper.createUser(
                        1,
                        FullName(firstName: firstName, lastName: lastName),
                        dni,
                        email,
                        password,
                        profilePictureUrl,
                        address,
                        phone,
                        birthdayDate);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  }),
            ],
          )),
        ),
      ),
    );
  }
}
