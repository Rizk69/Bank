class Countries {
  final bool status;
  final String message;
  final List<CountryModel> country; // Update the type to CountryModel

  Countries({
    required this.status,
    required this.message,
    required this.country,
  });

  factory Countries.fromJson(Map<String, dynamic> json) {
    return Countries(
      status: json['status'],
      message: json['message'],
      country: List<CountryModel>.from(
        json['country']
            .map((countryJson) => CountryModel.fromJson(countryJson)),
      ),
    );
  }
}

class CountryModel {
  final int id;
  final String name;
  final String img;
  final String code;

  CountryModel({
    required this.id,
    required this.name,
    required this.img,
    required this.code,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      code: json['code'],
    );
  }
}
