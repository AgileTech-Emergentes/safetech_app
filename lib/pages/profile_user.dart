import 'dart:convert';
import 'package:flutter/material.dart';

class Profile_user extends StatefulWidget {
  const Profile_user({Key? key}) : super(key: key);
  @override
  State<Profile_user> createState() => _Profile_userState();
  static const String routeName = "/profile_user";
}

class _Profile_userState extends State<Profile_user> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
