import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:safetech_app/models/user.dart';

class HttpHelper {
  Future<List> fetchUsers() async {
    String urlString =
        'https://neural-guard-366803.rj.r.appspot.com/api/v1/users';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List users = jsonResponse.map((map) => User.fromJson(map)).toList();
      return users;
    }
    return [];
  }

  Future<User> fetchUserById(int id) async {
    String urlString =
        'https://neural-guard-366803.rj.r.appspot.com/api/v1/users/${id}';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      User user = User.fromJson(jsonResponse);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> fetchByUserEmail(String email) async {
    String urlString =
        'https://neural-guard-366803.rj.r.appspot.com/api/v1/users/emails/${email}';
    Uri url = Uri.parse(urlString);

    http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      User user = User.fromJson(jsonResponse);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
