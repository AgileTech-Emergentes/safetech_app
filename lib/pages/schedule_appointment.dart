import 'package:flutter/material.dart';
import 'package:safetech_app/models/appliance.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/utils/http_new_appointment.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment({Key? key}) : super(key: key);

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
  static const String routeName = "/schedule_appointment";
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  List technicals = [];
  List shifts = [];
  String _chosenValue = 'Mañana';
  String _chosenValue2 = '07:00';
  var fisrtShift = ["07:00", "09:00", "11:00", "13:00"];
  var secondShift = ["15:00", "17:00", "19:00", "21:00"];
  var selectedShift = ["07:00", "09:00", "11:00", "13:00"];
  var shiftsNames = ["Mañana", "Tarde"];
  int shiftId = 1;
  DateTime selectedDate = DateTime.now();

  HttpNewAppointment httpNewAppointment = HttpNewAppointment();

  Appliance selectedAppliance = Appliance(
    id: 0,
    name: '',
    imgUrl: '',
    diagnosisCost: Money(amount: 0, currency: ""),
  );

  Future getAppliances() async {
    httpNewAppointment.fetchAllShifts().then((value) => {
          setState(() {
            this.shifts = value;
          })
        });
  }

  Future getTechnicals() async {
    DateTime finalDate = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, int.parse(_chosenValue2.substring(0, 2)), 0, 0, 0, 0);
    httpNewAppointment
        .fetchTechnicalsByApplianceShiftAndDate(
            selectedAppliance.id, shiftId, finalDate.toIso8601String())
        .then((value) => {
              setState(() {
                this.technicals = value;
              })
            });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 14)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedAppliance =
            ModalRoute.of(context)?.settings.arguments as Appliance;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendar una cita"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text("Seleccionar fecha"),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _chosenValue,
              items: shiftsNames.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  switch (_chosenValue) {
                    case "Mañana":
                      selectedShift = fisrtShift;
                      _chosenValue2 = "07:00";
                      shiftId = 1;
                      break;
                    case "Tarde":
                      selectedShift = secondShift;
                      _chosenValue2 = "15:00";
                      shiftId = 2;
                      break;
                  }
                  _chosenValue = value!;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _chosenValue2,
              items: selectedShift.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _chosenValue2 = value!;
                });
                getTechnicals();
                print(technicals[0].dni);
              },
            ),
          ),
          Text("Fecha seleccionada: ${selectedDate.toLocal()}"),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: technicals.map((technical) {
                return GestureDetector(
                  onTap: (() => Navigator.pushNamed(
                      context, '/schedule_appointment',
                      arguments: technical)),
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(
                          technical.profilePictureUrl,
                          width: 200,
                          height: 160,
                        ),
                        Text(technical.dni),
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
