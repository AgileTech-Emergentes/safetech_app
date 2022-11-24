import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/appliance.dart';
import 'package:safetech_app/models/money.dart';
import 'package:safetech_app/utils/http_new_appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment({Key? key}) : super(key: key);

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
  static const String routeName = "/schedule_appointment";
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final problemDescriptionController = TextEditingController();
  List technicals = [];
  List shifts = [];
  String _chosenValue = 'Mañana';
  String _chosenValue2 = '07:00';
  var fisrtShift = ["07:00", "09:00", "11:00", "13:00"];
  var secondShift = ["15:00", "17:00", "19:00", "21:00"];
  var selectedShift = ["07:00", "09:00", "11:00", "13:00"];
  var shiftsNames = ["Mañana", "Tarde"];
  int shiftId = 1;
  DateTime? selectedDate;
  DateTime? finalDate;
  int? userId;

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

  Future getAllTechnicals() async {
    httpNewAppointment.fetchAllTechnicals().then((value) => {
          setState(() {
            this.technicals = value;
          })
        });
  }

  Future getShifts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    httpNewAppointment.fetchAllShifts().then((value) => {
          setState(() {
            this.shifts = value;
            this.userId = prefs.getInt('id');
          })
        });
  }

  Future getTechnicals() async {
    finalDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        int.parse(_chosenValue2.substring(0, 2)),
        0,
        0,
        0,
        0);
    httpNewAppointment
        .fetchTechnicalsByApplianceShiftAndDate(selectedAppliance.id, shiftId,
            finalDate!.toIso8601String() + '+00:00')
        .then((value) => {
              setState(() {
                this.technicals = value;
              })
            });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 14)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void buildShifts() {
    for (int i = 0; i < shifts.length; i++) {}
  }

  void initState() {
    super.initState();
    getShifts();
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedAppliance =
            ModalRoute.of(context)?.settings.arguments as Appliance;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shifts.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Agendar una cita"),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Agendar una cita"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                ),
                (selectedDate != null)
                    ? Text(
                        DateFormat('dd-MM-yyyy').format(selectedDate!),
                      )
                    : Text("Seleccione una fecha"),
              ],
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
                    _chosenValue = value!;
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
                onChanged: (selectedDate != null)
                    ? (value) {
                        setState(() {
                          _chosenValue2 = value!;
                        });
                        getTechnicals();
                        print(technicals[0].dni);
                      }
                    : null,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: technicals.map((technical) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 10),
                                          Text(
                                            'Resumen de la cita',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'Especialidad',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          selectedAppliance.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Técnico',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          technical.fullName.firstName +
                                              " " +
                                              technical.fullName.lastName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Fecha',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(selectedDate!),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Hora',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          _chosenValue2,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'País',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormField(
                                          controller: countryController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Escribe el país',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Ciudad',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormField(
                                          controller: cityController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Escribe la ciudad',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Dirección',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormField(
                                          controller: addressController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Escribe la dirección',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Descripción del problema',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextFormField(
                                          controller:
                                              problemDescriptionController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText:
                                                'Escribe una descripción',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await httpNewAppointment
                                            .createAppointment(
                                                countryController.text,
                                                cityController.text,
                                                addressController.text,
                                                problemDescriptionController
                                                    .text,
                                                selectedAppliance.id,
                                                userId!,
                                                finalDate!,
                                                technical.id);
                                        Navigator.popAndPushNamed(
                                            context, '/home_user');
                                      },
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                          Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              40),
                                        ),
                                      ),
                                      child: Text(
                                        'Reservar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        Navigator.popAndPushNamed(
                                            context, '/technical_profile',
                                            arguments: technical);
                                      },
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                          Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              40),
                                        ),
                                      ),
                                      child: Text(
                                        'Ver Perfil',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.network(
                              technical.profilePictureUrl,
                              width: 200,
                              height: 160,
                            ),
                          ),
                          Text(technical.fullName.firstName +
                              " " +
                              technical.fullName.lastName),
                          const Text("Tecnico")
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
