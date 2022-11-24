import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/address.dart';
import 'package:safetech_app/models/appliance.dart';
import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';
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

  Appointment appointment = new Appointment(
      id: 0,
      problemDescription: "",
      scheduledAt: DateTime.now(),
      address: Address(street: "", city: "", country: ""),
      status: "",
      reparationCost: Money(amount: 0, currency: ""),
      paymentStatus: "",
      technical: Technical(
          id: 0,
          fullName: FullName(firstName: "", lastName: ""),
          dni: "",
          email: "",          
          password: "",
          profilePictureUrl: "",
          address: "",
          phone: "",
          birthdayDate: "",
          score: 0,
          aboutMe: ""),
      user: User(
          id: 0,
          fullName: FullName(firstName: "", lastName: ""),
          dni: "",
          email: "",          
          password: "",
          profilePictureUrl: "",
          address: "",
          phone: "",
          birthdayDate: ""),
      appliance: Appliance(
        id: 0,
        name: "",
        diagnosisCost: Money(amount: 0, currency: ""),
        imgUrl: ""
      ),
  );

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

  void deleteAppointmentById(int id, int index){
    httpHelper.deleteAppointmentById(id).then((value){
      setState(() {
        this.appointments.removeAt(index);
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
        backgroundColor: Color.fromRGBO(115, 103, 240, 94),
      ),
       body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (BuildContext context, int index) { 
          Appointment appointment = appointments.firstWhere(
            (element) => element.id == appointments[index].id,
          orElse: () => Appointment(
            id: 0,
            problemDescription: "",
            scheduledAt: DateTime.now(),
            address: Address(street: "", city: "", country: ""),
            status: "",
            reparationCost: Money(amount: 0, currency: ""),
            paymentStatus: "",
            technical: Technical(
                id: 0,
                fullName: FullName(firstName: "", lastName: ""),
                dni: "",
                email: "",          
                password: "",
                profilePictureUrl: "",
                address: "",
                phone: "",
                birthdayDate: "",
                score: 0,
                aboutMe: ""),
            user: User(
                id: 0,
                fullName: FullName(firstName: "", lastName: ""),
                dni: "",
                email: "",          
                password: "",
                profilePictureUrl: "",
                address: "",
                phone: "",
                birthdayDate: ""),
            appliance: Appliance(
              id: 0,
              name: "",
              diagnosisCost: Money(amount: 0, currency: ""),
              imgUrl: ""
            ),          
          ));
          return Container(          
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(appointments[index].technical.profilePictureUrl),
                            ),
                            ),
                          SizedBox(width: 10), 
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
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
                                   fontSize: 18,
                                   fontWeight: FontWeight.bold                                
                              )),
                              SizedBox(height: 5),  
                              Text('Reparation of ' + appointments[index].appliance.name,
                                   style: TextStyle(
                                   color: Colors.black                              
                              )),
                            ],
                          ), 
                          ),           
                          SizedBox(width: 5),
                          Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Container( 
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {  
                                    showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: Text('Cancel Appointment'),
                                        content: Text('Are you sure you want to cancel this appointment?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {  
                                              deleteAppointmentById(appointments[index].id, index);
                                              Navigator.of(context).pop();                                                                                        
                                            },                                            
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      ));
                                  }, 
                                  color: Colors.red,                        
                                ),
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () { 
                                    showDialog(
                                      context: context, 
                                      builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                        padding: const EdgeInsets.all(15.0),                         
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 10), 
                                            Text('Information Details',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                 color: Colors.black,
                                                 fontSize: 25,
                                                 fontWeight: FontWeight.bold                                                                                 
                                            )),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [                                               
                                                SizedBox(height: 10),
                                                Text('Technical: ' + appointment.technical.fullName.firstName + ' ' + appointment.technical.fullName.lastName,
                                                   style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15                                                                                
                                                 )),
                                                 SizedBox(height: 10),
                                                 Text('Appliance: ' + appointment.appliance.name,
                                                   style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 15                                                                                 
                                                 )),
                                                SizedBox(height: 10),
                                                Text('Date: ' + DateFormat('yyyy-MM-dd HH:mm a').format(appointment.scheduledAt),                                                 
                                                  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15                                                                               
                                                   )),
                                                SizedBox(height: 10),
                                                Text('Address: ' + appointment.address.street + ', ' + appointment.address.city + ', ' + appointment.address.country,
                                                  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15                                                                                
                                                  )),
                                                SizedBox(height: 10),
                                                Text('Description: ' + appointment.problemDescription,
                                                  style: TextStyle(
                                                   color: Colors.black,
                                                  fontSize: 15                                                                                
                                                  ))
                                              ],
                                            ), 
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                               style: ElevatedButton.styleFrom(
                                                primary: Color.fromRGBO(255, 159, 68, 100),
                                               ),
                                              onPressed: ()=> Navigator.pop(context), 
                                              child: Text('CLOSE'),
                                            )
                                           ]),  
                                      ))
                                    );   
                                  },
                                  color: Color.fromRGBO(255, 159, 68, 100),
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
            );
          }),        
        );     
    }
  }
}