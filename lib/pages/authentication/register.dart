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
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
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
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (controllerFirstName) {
                      if (controllerFirstName == null ||
                          controllerFirstName.isEmpty) {
                        return 'Por favor ingrese su nombre';
                      }
                      return null;
                    },
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
                  TextFormField(
                    validator: (controllerLastName) {
                      if (controllerLastName == null ||
                          controllerLastName.isEmpty) {
                        return 'Por favor ingrese su apellido';
                      }
                      return null;
                    },
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (controllerDni) {
                      if (controllerDni == null || controllerDni.isEmpty) {
                        return 'Por favor ingrese su DNI';
                      }
                      if (controllerDni.length < 8) {
                        return 'Por favor ingrese un DNI válido';
                      }
                      return null;
                    },
                    controller: controllerDni,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      labelText: 'DNI',
                      helperText: controllerDni.text.length.toString() + '/8',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (controllerEmail) {
                      if (controllerEmail == null || controllerEmail.isEmpty) {
                        return 'Por favor ingrese su email';
                      }
                      if (!controllerEmail.contains('@') ||
                          !controllerEmail.contains('.')) {
                        return 'Por favor ingrese un email válido';
                      }
                      return null;
                    },
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      labelText: 'Email',
                      helperText: 'example@example.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (controllerPassword) {
                      if (controllerPassword == null ||
                          controllerPassword.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      if (controllerPassword.length < 5) {
                        return 'Por favor ingrese una contraseña mayor a 4 dígitos';
                      }
                      return null;
                    },
                    controller: controllerPassword,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 10,
                        ),
                        isDense: true,
                        labelText: 'Contraseña',
                        helperText: 'Ej. xxxxx',
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
                  TextFormField(
                    validator: (controllerAddress) {
                      if (controllerAddress == null ||
                          controllerAddress.isEmpty) {
                        return 'Por favor ingrese su direccion';
                      }
                      return null;
                    },
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
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (controllerPhone) {
                      if (controllerPhone == null || controllerPhone.isEmpty) {
                        return 'Por favor ingrese su telefono';
                      }
                      return null;
                    },
                    controller: controllerPhone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      labelText: 'Teléfono',
                      helperText: controllerPhone.text.length.toString() + '/9',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (controllerBirthdayDate) {
                      if (controllerBirthdayDate == null ||
                          controllerBirthdayDate.isEmpty) {
                        return 'Por favor ingrese su fecha de nacimiento';
                      }
                      return null;
                    },
                    controller: controllerBirthdayDate,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 10,
                        ),
                        labelText: 'Fecha de nacimiento',
                        helperText: 'Ej. DD/MM/YYYY',
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
                        if (_formKey.currentState!.validate()) {
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
                              FullName(
                                  firstName: firstName, lastName: lastName),
                              dni,
                              email,
                              password,
                              profilePictureUrl,
                              address,
                              phone,
                              birthdayDate);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        }
                      }),
                ],
              )),
            ),
          )),
    );
  }
}
