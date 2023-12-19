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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['trans'] != null) {
      trans = <Trans>[];
      json['trans'].forEach((v) {
        trans!.add(new Trans.fromJson(v));
      });
    }
    if (json['traders'] != null) {
      traders = <Traders>[];
      json['traders'].forEach((v) {
        traders!.add(new Traders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.trans != null) {
      data['trans'] = this.trans!.map((v) => v.toJson()).toList();
    }
    if (this.traders != null) {
      data['traders'] = this.traders!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['frout_id'] = this.img;
    data['back_id'] = this.img;
    data['account_number'] = this.accountNumber;
    data['balance'] = this.balance;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_img'] = this.senderImg;
    data['sender_ID'] = this.senderID;
    data['sender_first_name'] = this.senderFirstName;
    data['sender_last_name'] = this.senderLastName;
    data['receiver_img'] = this.receiverImg;
    data['receiver_ID'] = this.receiverID;
    data['receiver_first_name'] = this.receiverFirstName;
    data['receiver_last_name'] = this.receiverLastName;
    data['final_amount'] = this.finalAmount;
    data['created_at'] = this.createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['activity_id'] = this.activityId;
    data['activity_name'] = this.activityName;
    data['discount'] = this.discount;
    return data;
  }
}
