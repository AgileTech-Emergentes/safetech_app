import 'dart:convert';
import 'dart:io';

import 'package:safetech_app/models/appliance.dart';
import 'package:http/http.dart' as http;
import 'package:safetech_app/models/technical.dart';

import '../models/shift.dart';

class HttpNewAppointment {
  String baseUrl = 'https://neural-guard-366803.rj.r.appspot.com/api/v1/';

  Future<List> fetchApplianceByName(String name) async {
    String urlString = baseUrl + 'appliances/name/${name}';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List appliances =
          jsonResponse.map((map) => Appliance.fromJson(map)).toList();
      return appliances;
    }
    return [];
  }

  Future<List> fetchAllAppliances() async {
    String urlString = baseUrl + 'appliances';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List appliances =
          jsonResponse.map((map) => Appliance.fromJson(map)).toList();
      return appliances;
    }
    return [];
  }

  Future<List> fetchAllShifts() async {
    String urlString = baseUrl + 'shifts';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List shifts = jsonResponse.map((map) => Shift.fromJson(map)).toList();
      return shifts;
    }
    return [];
  }

  Future<List> fetchTechnicalsByApplianceShiftAndDate (
    int applianceId, int shiftId, String date) async {
    String urlString = baseUrl +
        'technicals/appliance/${applianceId}/shift/${shiftId}/date/${date}';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List technicians =
          jsonResponse.map((map) => Technical.fromJson(map)).toList();
      return technicians;
    }
    return [];
  }
}
