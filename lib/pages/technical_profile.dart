import 'package:flutter/material.dart';

class TechnicalProfile extends StatefulWidget {
  const TechnicalProfile({Key? key}) : super(key: key);

  @override
  State<TechnicalProfile> createState() => _TechnicalProfileState();
  static const String routeName = "/technical_profile";
}

class _TechnicalProfileState extends State<TechnicalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technical Profile'),
      ),
      body: Center(
        child: Text('Technical Profile'),
      ),
    );
  }
}