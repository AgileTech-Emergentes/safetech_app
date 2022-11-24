import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:safetech_app/models/address.dart';
import 'package:safetech_app/models/appliance.dart';
import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';
import 'package:safetech_app/utils/http_helper.dart';

class Review extends StatefulWidget {
  static const String routeName = "/review";
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
  
}

class _ReviewState extends State<Review> {
  HttpHelper httpHelper = HttpHelper();
  int id = 0;

  Appointment appointment = new Appointment(
      id: 0,
      problemDescription: "",
      scheduledAt: DateTime.now(),
      address: Address(street: "", city: "", country: ""),
      status: "",
      reparationCost: Money(amount: 0, currency: ""),
      paymentStatus: "",
      technical: Technical(
          id: 0,
          fullName: FullName(firstName: "", lastName: ""),
          dni: "",
          email: "",          
          password: "",
          profilePictureUrl: "",
          address: "",
          phone: "",
          birthdayDate: "",
          score: 0,
          aboutMe: ""),
      user: User(
          id: 0,
          fullName: FullName(firstName: "", lastName: ""),
          dni: "",
          email: "",          
          password: "",
          profilePictureUrl: "",
          address: "",
          phone: "",
          birthdayDate: ""),
      appliance: Appliance(
        id: 0,
        name: "",
        diagnosisCost: Money(amount: 0, currency: ""),
        imgUrl: ""
      ),
  );

  final TextEditingController controllerText = TextEditingController();

  @override
  void initState() {
    httpHelper = HttpHelper();
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        appointment = ModalRoute.of(context)!.settings.arguments as Appointment;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Review'),
        backgroundColor: Color.fromRGBO(115, 103, 240, 94),
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return new ListView(
      controller: ScrollController(),
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        SizedBox(height: 15),
        Text(
          "Cuéntanos como fue tu experiencia con el servicio recibido por el técnico " + appointment.technical.fullName.firstName,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 15),
        Container(
          height: 150,
          child: TextField(
            controller: controllerText,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ), 
        SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(255, 159, 68, 100),
          ),
          onPressed: () async {
            // Validate returns true if the form is valid, or false otherwise.
            if (controllerText.text.isNotEmpty) {
              String text = controllerText.text;

              await httpHelper.createReview(text, appointment.user.id, appointment.technical.id, appointment.id);
              Navigator.pop(context);
            }
          },
          child: Text('Enviar'),
        ),
      ],

    );
  }
}