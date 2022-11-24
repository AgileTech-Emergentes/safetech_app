import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safetech_app/models/fullname.dart';
import 'package:safetech_app/models/technical.dart';

import '../utils/http_new_appointment.dart';

class TechnicalProfile extends StatefulWidget {
  const TechnicalProfile({Key? key}) : super(key: key);

  @override
  State<TechnicalProfile> createState() => _TechnicalProfileState();
  static const String routeName = "/technical_profile";
}

class _TechnicalProfileState extends State<TechnicalProfile> {
  HttpNewAppointment httpNewAppointment = HttpNewAppointment();
  List reviews = [];
  Technical? scoreTechnical;
  Technical selectedTechnical = Technical(
    id: 0,
    dni: "",
    password: "",
    aboutMe: "",
    birthdayDate: "",
    score: 0,
    profilePictureUrl: "",
    phone: "",
    address: "",
    fullName: FullName(firstName: "", lastName: ""),
    email: "",
  );

  Future getReviews(int id) async {
    httpNewAppointment.fetchReviewsByTechnicalId(id).then((value) => {
          setState(() {
            this.reviews = value;
          })
        });
  }

  Future getScore(int id) async {
    httpNewAppointment.getAverageScoreByTechnicalId(id).then((value) => {
          setState(() {
            this.scoreTechnical = value;
          })
        });
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedTechnical =
            ModalRoute.of(context)?.settings.arguments as Technical;
        getReviews(selectedTechnical.id);
        getScore(selectedTechnical.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Perfil del técnico ' + selectedTechnical.fullName.firstName),
        backgroundColor: Color.fromRGBO(115, 103, 240, 94),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(selectedTechnical.profilePictureUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedTechnical.fullName.firstName +
                        ' ' +
                        selectedTechnical.fullName.lastName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    selectedTechnical.aboutMe,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Fecha de nacimiento: ' +
                        DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(selectedTechnical.birthdayDate)),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Teléfono: ' + selectedTechnical.phone,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Dirección: ' + selectedTechnical.address,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Email: ' + selectedTechnical.email,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Puntuación: ' +
                        (scoreTechnical != null
                            ? scoreTechnical!.score.toString()
                            : '0'),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading:
                        Image.network(reviews[index].user.profilePictureUrl),
                    title: Text(
                      reviews[index].user.fullName.firstName +
                          " " +
                          reviews[index].user.fullName.lastName +
                          " | Puntaje: " +
                          reviews[index].score.toString(),
                    ),
                    subtitle: Text(reviews[index].text),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
