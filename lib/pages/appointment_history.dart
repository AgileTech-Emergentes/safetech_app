import 'dart:convert';
import 'package:flutter/material.dart';

class Appointment_history extends StatefulWidget {
  const Appointment_history({Key? key}) : super(key: key);

  @override
  State<Appointment_history> createState() => _Appointment_historyState();
  static const String routeName = "/appointment_history";
}

class _Appointment_historyState extends State<Appointment_history> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Appointment History'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Appointment History'),
      ),
    );
  }
}