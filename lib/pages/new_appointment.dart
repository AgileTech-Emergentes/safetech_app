import 'dart:convert';
import 'package:flutter/material.dart';

class New_appointment extends StatefulWidget {
  const New_appointment({Key? key}) : super(key: key);

  @override
  State<New_appointment> createState() => _New_appointmentState();
  static const String routeName = "/new_appointment";
}

class _New_appointmentState extends State<New_appointment> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('New Appointment'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('New Appointment'),
      ),
    );
  }
}