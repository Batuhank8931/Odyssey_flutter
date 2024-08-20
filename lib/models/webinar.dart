class Webinar {
  final int id; // id is an integer
  final String title;
  final String? subtitle;
  final String? description;
  final String? date;
  final String? image;

  Webinar({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.date,
    this.image,
  });

  factory Webinar.fromJson(Map<String, dynamic> json) {
    return Webinar(
      id: json['id'],
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      image: json['image'] as String?,
    );
  }
}
