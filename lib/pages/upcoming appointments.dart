import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/utils/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Upcoming_appointments extends StatefulWidget {
  const Upcoming_appointments({Key? key}) : super(key: key);

  @override
  State<Upcoming_appointments> createState() => _Upcoming_appointmentsState();
  static const String routeName = "/upcoming_appointments";
}

class _Upcoming_appointmentsState extends State<Upcoming_appointments> {
  HttpHelper httpHelper = HttpHelper();
  List appointments = [];    

  @override
  void initState(){
    appointments = [];
    httpHelper = HttpHelper();
    fetchAppointments();
    super.initState();
  }

  Future fetchAppointments() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');

    httpHelper.fetchAppointmentsByUserIdAndStatus(id!, "SCHEDULED").then((value){
      setState(() {
        this.appointments = value;
      });
    });
  } 

  @override
  Widget build(BuildContext context) {
  if(appointments.length == 0){
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    else {
      return Scaffold(
       appBar: AppBar(
        title: Text('Upcoming Appointments'),
        backgroundColor: Colors.blue,
      ),
       body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Card(
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(appointments[index].technical.profilePictureUrl),
                            ),
                            ),
                          SizedBox(width: 10),                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('yyyy-MM-dd HH:mm a').format(appointments[index].scheduledAt),
                                   style: TextStyle(
                                   color: Colors.black                               
                              )),
                              SizedBox(height: 5), 
                              Text('Appointment with ' + appointments[index].technical.fullName.firstName + ' ' + appointments[index].technical.fullName.lastName,
                                   style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 15,
                                   fontWeight: FontWeight.bold                                
                              )),
                              SizedBox(height: 5),  
                              Text('Reparation of ' + appointments[index].appliance.name,
                                   style: TextStyle(
                                   color: Colors.black                              
                              )),
                            ],
                          ),                                              
                          SizedBox(width: 5),
                          Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                          child: Container( 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {      
                                  }, 
                                  color: Colors.blue,                        
                                ),
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () {      
                                  },
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ), 
                        ),
                      ]),
                    ],
                  ), 
              ),
             ),
            ),
          ),        
        );     
    }
  }
}