class HomeModel {
  bool? status;
  String? message;
  User? user;
  List<Trans>? trans;
  List<Traders>? traders;

  HomeModel({this.status, this.message, this.user, this.trans, this.traders});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['trans'] != null) {
      trans = <Trans>[];
      json['trans'].forEach((v) {
        trans!.add(Trans.fromJson(v));
      });
    }
    if (json['traders'] != null) {
      traders = <Traders>[];
      json['traders'].forEach((v) {
        traders!.add(Traders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (trans != null) {
      data['trans'] = trans!.map((v) => v.toJson()).toList();
    }
    if (traders != null) {
      data['traders'] = traders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? img;
  String? froutid;
  String? backid;
  String? accountNumber;
  String? balance;

  User({this.img, this.accountNumber, this.balance});

  User.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    accountNumber = json['account_number'];
    froutid = json['frout_id'];
    backid = json['back_id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['frout_id'] = img;
    data['back_id'] = img;
    data['account_number'] = accountNumber;
    data['balance'] = balance;
    return data;
  }
}

class Trans {
  int? id;
  String? senderImg;
  String? senderID;
  String? senderFirstName;
  String? senderLastName;
  String? receiverImg;
  String? receiverID;
  String? receiverFirstName;
  String? receiverLastName;
  int? finalAmount;
  String? createdAt;

  Trans(
      {this.id,
      this.senderImg,
      this.senderID,
      this.senderFirstName,
      this.senderLastName,
      this.receiverImg,
      this.receiverID,
      this.receiverFirstName,
      this.receiverLastName,
      this.finalAmount,
      this.createdAt});

  Trans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderImg = json['sender_img'];
    senderID = json['sender_ID'];
    senderFirstName = json['sender_first_name'];
    senderLastName = json['sender_last_name'];
    receiverImg = json['receiver_img'];
    receiverID = json['receiver_ID'];
    receiverFirstName = json['receiver_first_name'];
    receiverLastName = json['receiver_last_name'];
    finalAmount = json['final_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_img'] = senderImg;
    data['sender_ID'] = senderID;
    data['sender_first_name'] = senderFirstName;
    data['sender_last_name'] = senderLastName;
    data['receiver_img'] = receiverImg;
    data['receiver_ID'] = receiverID;
    data['receiver_first_name'] = receiverFirstName;
    data['receiver_last_name'] = receiverLastName;
    data['final_amount'] = finalAmount;
    data['created_at'] = createdAt;
    return data;
  }
}

class Traders {
  int? id;
  String? img;
  int? activityId;
  String? activityName;
  int? discount;

  Traders(
      {this.id, this.img, this.activityId, this.activityName, this.discount});

  Traders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    activityId = json['activity_id'];
    activityName = json['activity_name'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    data['activity_id'] = activityId;
    data['activity_name'] = activityName;
    data['discount'] = discount;
    return data;
  }
}

class CurrencyModel {
  bool status;
  String message;
  List<Currency> currencies;

  CurrencyModel({
    required this.status,
    required this.message,
    required this.currencies,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      status: json['status'],
      message: json['message'],
      currencies: (json['currencies'] as List<dynamic>)
          .map((currency) => Currency.fromJson(currency))
          .toList(),
    );
  }
}

class Currency {
  int? id;
  String? name;
  bool? active;

  Currency({
    required this.id,
    required this.name,
    required this.active,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'] as String?,
      active: json['active'] as bool?,
    );
  }
}
