class CashBackModel {
  bool? status;
  String? message;
  String? balance;
  List<Traders>? traders;
  List<Brands>? brands;

  CashBackModel(
      {this.status, this.message, this.balance, this.traders, this.brands});

  CashBackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    balance = json['balance'];
    if (json['traders'] != null) {
      traders = <Traders>[];
      json['traders'].forEach((v) {
        traders!.add(new Traders.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['balance'] = this.balance;
    if (this.traders != null) {
      data['traders'] = this.traders!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Traders {
  int? id;
  String? img;
  String? firstName;
  String? lastName;
  int? activityId;
  String? activityName;
  int? discount;

  Traders(
      {this.id,
      this.img,
      this.firstName,
      this.lastName,
      this.activityId,
      this.activityName,
      this.discount});

  Traders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    activityId = json['activity_id'];
    activityName = json['activity_name'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['activity_id'] = this.activityId;
    data['activity_name'] = this.activityName;
    data['discount'] = this.discount;
    return data;
  }
}

class Brands {
  int? id;
  String? img;
  String? firstName;
  String? lastName;
  int? activityId;
  String? activityName;
  int? discount;

  Brands(
      {this.id,
      this.img,
      this.firstName,
      this.lastName,
      this.activityId,
      this.activityName,
      this.discount});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    activityId = json['activity_id'];
    activityName = json['activity_name'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['activity_id'] = this.activityId;
    data['activity_name'] = this.activityName;
    data['discount'] = this.discount;
    return data;
  }
}
