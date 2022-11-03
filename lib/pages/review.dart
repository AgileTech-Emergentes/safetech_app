import 'dart:convert';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
  static const String routeName = "/review";
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Review'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Review'),
      ),
    );
  }
}