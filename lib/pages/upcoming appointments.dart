import 'dart:convert';
import 'package:flutter/material.dart';

class Upcoming_appointments extends StatefulWidget {
  const Upcoming_appointments({Key? key}) : super(key: key);

  @override
  State<Upcoming_appointments> createState() => _Upcoming_appointmentsState();
  static const String routeName = "/upcoming_appointments";
}

class _Upcoming_appointmentsState extends State<Upcoming_appointments> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Appointments'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Upcoming Appointments'),
      ),
    );
  }
}