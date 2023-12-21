class Novel {
  Novel({
    required this.title,
    required this.writer,
    required this.novel_url,
    required this.image_url,
    required this.description,
  });

  String title;
  String writer;
  String novel_url;
  String image_url;
  String description;

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      title: json['title'],
      writer: json['writer'],
      novel_url: json['novel_url'],
      image_url: json['image_url'],
      description: json['description'],
    );
  }
}
