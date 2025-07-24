class Activity {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final String time;
  final String place;

  Activity({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    required this.time,
    required this.place,
  });
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      image: json['image'],
      title: json['title'], // Parse new field
      subtitle: json['subtitle'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      place: json['place'],
    );
  }
}
