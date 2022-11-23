import 'package:flutter/material.dart';
import 'package:safetech_app/pages/Upcoming%20appointments.dart';
import 'package:safetech_app/pages/appointment_history.dart';
import 'package:safetech_app/pages/authentication/login.dart';
import 'package:safetech_app/pages/authentication/register.dart';
import 'package:safetech_app/pages/home_user.dart';
import 'package:safetech_app/pages/new_appointment.dart';
import 'package:safetech_app/pages/profile_user.dart';
import 'package:safetech_app/pages/review.dart';
import 'package:safetech_app/pages/schedule_appointment.dart';

void main() {
  runApp(new MaterialApp(
    title: 'SafeTech',
    theme: ThemeData(fontFamily: 'NotoSans'),
    home: new Login(),
    routes: <String, WidgetBuilder>{
      Login.routeName: (BuildContext context) => new Login(),
      Register.routeName: (BuildContext context) => new Register(),
      Home_user.routeName: (BuildContext context) => new Home_user(),
      Profile_user.routeName: (BuildContext context) => new Profile_user(),
      New_appointment.routeName: (BuildContext context) =>
          new New_appointment(),
      Upcoming_appointments.routeName: (BuildContext context) =>
          new Upcoming_appointments(),
      Appointment_history.routeName: (BuildContext context) =>
          new Appointment_history(),
      ScheduleAppointment.routeName: (BuildContext context) =>
          new ScheduleAppointment(),
      Review.routeName: (BuildContext context) => 
          new Review(),
    },
  ));
}
