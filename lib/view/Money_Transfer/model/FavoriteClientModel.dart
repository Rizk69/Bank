class FavoriteClient {
  final int id;
  final String firstName;
  final String lastName;
  final String? img;
  final String phone;

  FavoriteClient({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.img,
    required this.phone,
  });

  factory FavoriteClient.fromJson(Map<String, dynamic> json) {
    return FavoriteClient(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      img: json['img'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'img': img,
      'phone': phone,
    };
  }
}
