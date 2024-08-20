import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/webinar.dart';

class WebinarDetailScreen extends StatelessWidget {
  final int webinarId;
  final ApiService apiService = ApiService();

  WebinarDetailScreen({required this.webinarId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webinar Details'),
      ),
      body: FutureBuilder<Webinar>(
        future: apiService.fetchWebinarById(webinarId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Webinar not found.'));
          } else {
            final webinar = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    webinar.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  if (webinar.subtitle != null)
                    Text(
                      webinar.subtitle!,
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  SizedBox(height: 8),
                  if (webinar.description != null)
                    Text(
                      webinar.description!,
                      style: TextStyle(fontSize: 16),
                    ),
                  SizedBox(height: 8),
                  Text('Tarih: ${webinar.date ?? 'Bilinmiyor'}'),
                  if (webinar.image != null) ...[
                    SizedBox(height: 16),
                    Image.network(webinar.image!),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
