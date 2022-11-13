import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/user.dart';
import 'package:safetech_app/utils/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileUser extends StatefulWidget {
  const EditProfileUser(this.user);
  final User user;
  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  HttpHelper httpHelper = HttpHelper();
  User? user;

  DateTime selectedDate = DateTime.now();

  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerDni = TextEditingController();
  final TextEditingController controllerProfilePictureUrl =
      TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerBirthdayDate = TextEditingController();

  @override
  void initState() {
    httpHelper = HttpHelper();
    controllerFirstName.text = widget.user.fullName.firstName;
    controllerLastName.text = widget.user.fullName.lastName;
    controllerDni.text = widget.user.dni;
    controllerProfilePictureUrl.text = widget.user.profilePictureUrl;
    controllerAddress.text = widget.user.address;
    controllerPhone.text = widget.user.phone;
    controllerBirthdayDate.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.user.birthdayDate));
    super.initState();
  }

  Future<void> updateUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String editUser = jsonEncode(user);
    prefs.setString('user', editUser);
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Text('Information Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
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
                  child: Text('Guardar'),
                  onPressed: () async {
                    FullName fullName = FullName(
                        firstName: controllerFirstName.text,
                        lastName: controllerLastName.text);
                    String dni = controllerDni.text;
                    String profilePictureUrl = controllerProfilePictureUrl.text;
                    String address = controllerAddress.text;
                    String phone = controllerPhone.text;
                    String birthdayDate = controllerBirthdayDate.text;

                    User userInfo = User(
                        id: widget.user.id,
                        fullName: fullName,
                        dni: dni,
                        email: widget.user.email,
                        password: widget.user.password,
                        profilePictureUrl: profilePictureUrl,
                        address: address,
                        phone: phone,
                        birthdayDate: birthdayDate);

                    await httpHelper.updateUser(widget.user.id, userInfo);
                    updateUserData(userInfo);
                    Navigator.pop(context, userInfo);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
