class ApiResponseCheckScan {
  bool status;
  String message;
  List<Currency> currencies;
  Receiver receiver;

  ApiResponseCheckScan({
    required this.status,
    required this.message,
    required this.currencies,
    required this.receiver,
  });

  factory ApiResponseCheckScan.fromJson(Map<String, dynamic> json) {
    return ApiResponseCheckScan(
      status: json['status'],
      message: json['message'],
      currencies: List<Currency>.from(
        json['currencies'].map((currency) => Currency.fromJson(currency)),
      ),
      receiver: Receiver.fromJson(json['receiver']),
    );
  }
}

class Currency {
  int id;
  String name;

  Currency({required this.id, required this.name});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Receiver {
  int receiverId;
  String firstName;
  String lastName;
  dynamic img;

  Receiver({
    required this.receiverId,
    required this.firstName,
    required this.lastName,
    required this.img,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      receiverId: json['receiver_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      img: json['img'],
    );
  }
}
