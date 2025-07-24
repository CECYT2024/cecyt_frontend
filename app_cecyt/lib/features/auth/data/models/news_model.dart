//Modelo del objeto Noticias


class News {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String date;

  News({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
  });
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      image: json['image'],
      title: json['title'], 
      subtitle: json['subtitle'],
      description: json['description'],
      date: json['date'],
    );
  }
}
