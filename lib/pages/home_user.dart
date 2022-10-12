import 'dart:convert';
import 'package:flutter/material.dart';

class Home_user extends StatefulWidget {
  const Home_user({Key? key}) : super(key: key);
  @override
  State<Home_user> createState() => _Home_userState();
  static const String routeName = "/home_user";
}

class _Home_userState extends State<Home_user> {
  
  Drawer getDrawer(BuildContext context) {
    var header = DrawerHeader(
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SafeTech',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            Text(
              'User',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );

    Container getItem(Icon icon, String description, String route) {
      return Container(
        padding: EdgeInsets.only(left: 10.0),
        child: ListTile(
          leading: icon,
          title: Text(description),
          onTap: () {
            setState(() {
              Navigator.of(context).pushNamed(route);
            });
          },
        ),
      );
    }

    ListView listView = ListView(
      children: [
        header,
        getItem(new Icon(Icons.home), "Home", "/home_user"),
        getItem(new Icon(Icons.person), "Profile", "/profile_user"),
        getItem(new Icon(Icons.add), "New Appointment", "/new_appointment"),
        getItem(new Icon(Icons.calendar_today), "Upcoming Appointments", "/upcoming_appointments"),
        getItem(new Icon(Icons.history), "Appointment History", "/appointment_history"),
        getItem(new Icon(Icons.logout), "Logout", "/login"),
      ],
    );

    return new Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home User'),
      ),
      body: Center(
        child: Text('Home User'),
      ),
      drawer: new Drawer(
        child: getDrawer(context),
      ),
    );
  }
}
