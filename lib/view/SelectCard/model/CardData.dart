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
  List<ColorItem> colors; // Updated to List<ColorItem>
  String description;
  int request;
  int activityId;
  String activityName;

  CardItem({
    required this.id,
    required this.name,
    required this.imgs,
    required this.colors,
    required this.description,
    required this.request,
    required this.activityId,
    required this.activityName,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
      name: json['name'],
      imgs:
          Map.from(json['imgs']).map((k, v) => MapEntry<String, String>(k, v)),
      colors: List<ColorItem>.from(
          json['colors'].map((x) => ColorItem.fromJson(x))),
      // Parsing the colors list
      description: json['dec'],
      activityId: json['activity_id'],
      activityName: json['activity_name'],
      request: json['request'],
    );
  }
}

class ColorItem {
  int id;
  String name;
  String color;

  ColorItem({
    required this.id,
    required this.name,
    required this.color,
  });

  factory ColorItem.fromJson(Map<String, dynamic> json) {
    return ColorItem(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
