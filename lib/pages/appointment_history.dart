import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/address.dart';
import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/utils/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment_history extends StatefulWidget {
  const Appointment_history({Key? key}) : super(key: key);

  @override
  State<Appointment_history> createState() => _Appointment_historyState();
  static const String routeName = "/appointment_history";
}

class _Appointment_historyState extends State<Appointment_history> {
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

    httpHelper.fetchAppointmentsByUserIdAndStatus(id!, "FINISHED").then((value){
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
        title: Text('Appointment History'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [                     
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
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold                                
                              )),
                              SizedBox(height: 5),  
                              Text('Reparation of ' + appointments[index].appliance.name,
                                   style: TextStyle(
                                   color: Colors.black                              
                              )),
                            ],
                          ),                    
                      SizedBox(width: 25),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Container( 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                              icon: const Icon(Icons.description),
                              onPressed: () {      
                              }, 
                              color: Colors.blue,                        
                              ),

                              IconButton(
                              icon: Icon(Icons.reviews),
                              onPressed: () {      
                              },                          
                              color: Colors.blue,
                              ),
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

