import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/webinar.dart';

class ApiService {
  final String baseUrl = 'https://kayit.turkecon.org/api/webinars';

  Future<List<Webinar>> fetchWebinars() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Webinar> webinars = data.map((json) => Webinar.fromJson(json)).toList();
      webinars.sort((a, b) => a.date!.compareTo(b.date!));
      return webinars;
    } else {
      throw Exception('Failed to load webinars');
    }
  }

  Future<Webinar> fetchWebinarById(int id) async {
    final url = Uri.parse('$baseUrl?id=$id');

    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body)[0];
      return Webinar.fromJson(data);
    } else {
      throw Exception('Failed to load webinar');
    }
  }
}
