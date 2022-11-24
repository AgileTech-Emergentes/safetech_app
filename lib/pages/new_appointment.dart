import 'package:flutter/material.dart';
import 'package:safetech_app/utils/http_new_appointment.dart';

class New_appointment extends StatefulWidget {
  const New_appointment({Key? key}) : super(key: key);

  @override
  State<New_appointment> createState() => _New_appointmentState();
  static const String routeName = "/new_appointment";
}

class _New_appointmentState extends State<New_appointment> {
  HttpNewAppointment httpNewAppointment = HttpNewAppointment();
  final searchController = TextEditingController();
  List appliances = [];

  Future getAppliances() async {
    httpNewAppointment.fetchAllAppliances().then((value) => {
          setState(() {
            this.appliances = value;
          })
        });
  }

  Future getApplianceByName(String name) async {
    httpNewAppointment.fetchApplianceByName(name).then((value) => {
          setState(() {
            this.appliances = value;
          })
        });
  }

  @override
  initState() {
    getAppliances();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (appliances.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Agendar una cita"),
          backgroundColor: Color.fromRGBO(115, 103, 240, 94),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Agendar una cita'),
          backgroundColor: Color.fromRGBO(115, 103, 240, 94),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                onSubmitted: ((value) => getApplianceByName(value)),
                onEditingComplete: () => getApplianceByName(searchController.text),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Buscar',
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: appliances.map((appliance) {
                  return GestureDetector(
                    onTap: (() => Navigator.pushNamed(context,'/schedule_appointment', arguments: appliance)),
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(
                            appliance.imgUrl,
                            width: 200,
                            height: 160,
                          ),
                          Text(appliance.name),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
