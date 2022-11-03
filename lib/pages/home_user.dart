import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/user.dart';
import 'package:safetech_app/utils/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class Home_user extends StatefulWidget {
  const Home_user({Key? key}) : super(key: key);
  @override
  State<Home_user> createState() => _Home_userState();
  static const String routeName = "/home_user";
}

class _Home_userState extends State<Home_user> {
  HttpHelper httpHelper = HttpHelper();

  List appointments = [];

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
    appointments = [];
    httpHelper = HttpHelper();
    fetchAppointmentsByUserIdAndStatus();
    fetchUser();
    super.initState();
  }

  Future fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userTemp = prefs.getString('user') ?? "";
    setState(() {
      if (userTemp != "") {
        user = User.fromJson(jsonDecode(userTemp) as Map<String, dynamic>);
      }
    });
  }

  Future fetchAppointmentsByUserIdAndStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    httpHelper
        .fetchAppointmentsByUserIdAndStatus(id!, "SCHEDULED")
        .then((value) {
      setState(() {
        this.appointments = value;
      });
    });
    return appointments;
  }

  Drawer getDrawer(BuildContext context) {
    fetchUser();
    var header = DrawerHeader(
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SafeTech',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePictureUrl),
                      radius: 20.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      user.fullName.firstName + " " + user.fullName.lastName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                )),
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
        getItem(new Icon(Icons.calendar_today), "Upcoming Appointments",
            "/upcoming_appointments"),
        getItem(new Icon(Icons.history), "Appointment History",
            "/appointment_history"),
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
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: imgList
                    .map((item) => Container(
                            child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(item,
                                      fit: BoxFit.cover, width: 1000.0),
                                ],
                              )),
                        )))
                    .toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: appointments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 10,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        "Appointment date: " +
                                            DateFormat('yyyy-MM-dd HH:mm a')
                                                .format(appointments[index]
                                                    .scheduledAt),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                              Text(appointments[index].problemDescription,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  DateFormat('yyyy-MM-dd HH:mm a')
                                      .format(appointments[index].scheduledAt),
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
      drawer: new Drawer(
        child: getDrawer(context),
      ),
    );
  }
}
