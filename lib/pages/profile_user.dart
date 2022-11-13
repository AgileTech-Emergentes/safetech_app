import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/user.dart';
import 'package:safetech_app/pages/edit_profile_user.dart';
import 'package:safetech_app/utils/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_user extends StatefulWidget {
  const Profile_user({Key? key}) : super(key: key);
  @override
  State<Profile_user> createState() => _Profile_userState();
  static const String routeName = "/profile_user";
}

class _Profile_userState extends State<Profile_user> {
  HttpHelper httpHelper = HttpHelper();

  DateTime selectedDate = DateTime.now();

  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerDni = TextEditingController();
  final TextEditingController controllerProfilePictureUrl =
      TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerBirthdayDate = TextEditingController();

  User user = new User(
      id: 1,
      fullName: FullName(firstName: "", lastName: ""),
      dni: "",
      email: "",
      password: "",
      profilePictureUrl: "",
      address: "",
      phone: "",
      birthdayDate: "");

  @override
  void initState() {
    httpHelper = HttpHelper();
    fetchUser();
    controllerFirstName.text = user.fullName.firstName;
    controllerLastName.text = user.fullName.lastName;
    controllerDni.text = user.dni;
    controllerProfilePictureUrl.text = user.profilePictureUrl;
    controllerAddress.text = user.address;
    controllerPhone.text = user.phone;
    controllerBirthdayDate.text = user.birthdayDate;
    super.initState();
  }

  Future fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = User.fromJson(
          jsonDecode(prefs.getString('user')!) as Map<String, dynamic>);
    });
    return user;
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.profilePictureUrl),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.fullName.firstName + " " + user.fullName.lastName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email: " + user.email,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text("Password: " + user.password,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text("DNI: " + user.dni,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text("Address: " + user.address,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text("Phone: " + user.phone,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text(
                              "Birthday Date: " +
                                  DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(user.birthdayDate)),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                  child: Text("Editar Perfil"),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            EditProfileUser(user))
                                          .then((value) => fetchUser());
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
