class CardData {
  int id;
  String name;
  Map<String, String> imgs;
  Map<String, String> colors;
  String description;
  int activityId;
  String activityName;

  CardData({
    required this.id,
    required this.name,
    required this.imgs,
    required this.colors,
    required this.description,
    required this.activityId,
    required this.activityName,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      id: json['id'],
      name: json['name'],
      imgs: Map<String, String>.from(json['imgs']),
      colors: Map<String, String>.from(json['colors']),
      description: json['dec'],
      activityId: json['activity_id'],
      activityName: json['activity_name'],
    );
  }
}
