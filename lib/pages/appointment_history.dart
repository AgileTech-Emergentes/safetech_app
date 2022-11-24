import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/address.dart';
import 'package:safetech_app/models/appliance.dart';
import 'package:safetech_app/models/applianceInfo.dart';
import 'package:safetech_app/models/appointment.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/models/report.dart';
import 'package:safetech_app/models/technical.dart';
import 'package:safetech_app/models/user.dart';
import 'package:safetech_app/pages/review.dart';
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
  List reports = [];

  Report report = new Report(
    id: 0,
    applianceInfo: ApplianceInfo(brand: "", model: "", type: ""),
    applianceDiagnostic: "",
    reparationDetails: "",
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
    appointment: Appointment(
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
        imgUrl: "https://http2.mlstatic.com/D_Q_NP_755894-MLA44631461178_012021-V.jpg"
      ),
  )
  );


  @override
  void initState(){
    appointments = [];
    reports = [];
    httpHelper = HttpHelper();
    fetchAppointments();
    fetchReports();
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

  Future fetchReports() async {  
    await httpHelper.fetchReports().then((value){
      setState(() {
        this.reports = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  if(appointments.length == 0){
      return Scaffold(
        appBar: AppBar(
          title: Text("Historial de citas"),
          backgroundColor: Color.fromRGBO(115, 103, 240, 94),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    else {
      return Scaffold(
       appBar: AppBar(
        title: Text('Appointment History'),
        backgroundColor: Color.fromRGBO(115, 103, 240, 94),
      ),
       body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (BuildContext context, int index) {
          Report report = reports.firstWhere(
            (element) => element.appointment.id == appointments[index].id,
            orElse: () => this.report
         );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
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
                      ),  
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Container( 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                              icon: const Icon(Icons.description),
                              onPressed: () {  
                                showDialog(
                                  context: context, 
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [                                            
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              child: Column(                                              
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10),
                                                Text('Report Details',
                                                   style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 15,
                                                   fontWeight: FontWeight.bold
                                                  ),                                            
                                                 ),
                                                SizedBox(height: 10),
                                                Text(report.appointment.appliance.name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20, 
                                                    fontWeight: FontWeight.bold
                                                  ),                                            
                                                ),
                                                SizedBox(height: 5),
                                                Text('Appointment with ' + report.technical.fullName.firstName + ' ' + report.technical.fullName.lastName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,                                                  
                                                  ),                                            
                                                ),
                                                Text('Scheduled at '+DateFormat('yyyy-MM-dd HH:mm a').format(report.appointment.scheduledAt),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,                                                  
                                                  ),                                            
                                                ),
                                              ]
                                            ),
                                            ),                                            
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 10),
                                                Text('Appliance Photo',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold                                                  
                                                  ),                                            
                                                ),
                                                Image.network(report.appointment.appliance.imgUrl, 
                                                width: MediaQuery.of(context).size.width * 0.5,)
                                              ]
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10),
                                                Text('Diagnostic',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,                                                  
                                                  ),                                            
                                                ),
                                                SizedBox(height: 5),
                                                Text(report.applianceDiagnostic,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,                                                  
                                                  ),                                            
                                                ),
                                                SizedBox(height: 10),
                                                Text('Reparation Details',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,    
                                                    fontWeight: FontWeight.bold                                              
                                                  ),                                            
                                                ),
                                                SizedBox(height: 5),
                                                Text(report.reparationDetails,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,                                                  
                                                  ),                                            
                                                ),
                                              ]
                                            )                                            

                                          ],

                                        ),
                                      ),

                                  )));
                              }, 
                              color: Color.fromRGBO(255, 159, 68, 100),                        
                              ),
                              IconButton(
                              icon: Icon(Icons.reviews),
                              onPressed: () { 
                                //navigation to review page
                                Navigator.pushNamed(
                                  context, 
                                  '/review', 
                                  arguments: appointments[index]
                                );
                              },                          
                              color: Color.fromRGBO(255, 159, 68, 100),
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
            );
           }
         ),        
        );     
    }
  }
}

