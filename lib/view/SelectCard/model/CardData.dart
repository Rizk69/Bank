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

class ResponseModelCardItem {
  bool status;
  String message;
  List<ImageItem> imgs;
  List<CardItem> cards;

  ResponseModelCardItem(
      {required this.status,
      required this.message,
      required this.imgs,
      required this.cards});

  factory ResponseModelCardItem.fromJson(Map<String, dynamic> json) =>
      ResponseModelCardItem(
        status: json['status'],
        message: json['message'],
        imgs: List<ImageItem>.from(
            json['imgs'].map((x) => ImageItem.fromJson(x))),
        cards:
            List<CardItem>.from(json['cards'].map((x) => CardItem.fromJson(x))),
      );
}

class ImageItem {
  int id;
  String img1;

  ImageItem({required this.id, required this.img1});

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        id: json['id'],
        img1: json['img_1'],
      );
}

class CardItem {
  int id;
  String name;
  Map<String, String> imgs;
  Map<String, String> colors;
  String description;
  int activityId;
  String activityName;

  CardItem(
      {required this.id,
      required this.name,
      required this.imgs,
      required this.colors,
      required this.description,
      required this.activityId,
      required this.activityName});

  factory CardItem.fromJson(Map<String, dynamic> json) => CardItem(
        id: json['id'],
        name: json['name'],
        imgs: Map.from(json['imgs'])
            .map((k, v) => MapEntry<String, String>(k, v)),
        colors: Map.from(json['colors'])
            .map((k, v) => MapEntry<String, String>(k, v)),
        description: json['dec'],
        activityId: json['activity_id'],
        activityName: json['activity_name'],
      );
}
