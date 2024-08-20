import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/webinar.dart';
import 'webinar_detail_screen.dart';

class WebinarListScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ders Çizelgesi'),
      ),
      body: FutureBuilder<List<Webinar>>(
        future: apiService.fetchWebinars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No webinars found.'));
          } else {
            final webinars = snapshot.data!;
            return ListView.builder(
              itemCount: webinars.length,
              itemBuilder: (context, index) {
                final webinar = webinars[index];
                return ListTile(
                  leading: webinar.image != null
                      ? Image.network(webinar.image!, width: 50, height: 50, fit: BoxFit.cover)
                      : null,
                  title: Text(webinar.title),
                  subtitle: Text('Tarih: ${webinar.date ?? 'Bilinmiyor'}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebinarDetailScreen(webinarId: webinar.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
