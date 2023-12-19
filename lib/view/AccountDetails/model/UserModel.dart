class UserModel {
  bool? status;
  String? message;
  User? user;
  int? countNotifications;

  UserModel({this.status, this.message, this.user, this.countNotifications});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    countNotifications = json['count_notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['count_notifications'] = this.countNotifications;
    return data;
  }
}

class User {
  int? id;
  String? img;
  String? firstName;
  String? lastName;
  String? email;
  String? countryName;
  String? phone;
  String? idNumber;
  String? accountNumber;
  String? balance;
  int? currencyId;
  String? currencyName;
  bool? active;
  String? accountType;
  String? lang;
  int? limitCart;
  int? limitAccount;
  int? limitTransferDay;
  int? limitTransferManth;
  int? limitReceptionDay;
  int? limitReceptionManth;

  User(
      {this.id,
      this.img,
      this.firstName,
      this.lastName,
      this.email,
      this.countryName,
      this.phone,
      this.idNumber,
      this.accountNumber,
      this.balance,
      this.currencyId,
      this.currencyName,
      this.active,
      this.accountType,
      this.lang,
      this.limitCart,
      this.limitAccount,
      this.limitTransferDay,
      this.limitTransferManth,
      this.limitReceptionDay,
      this.limitReceptionManth});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryName = json['country_name'];
    phone = json['phone'];
    idNumber = json['id_number'];
    accountNumber = json['account_number'];
    balance = json['balance'];
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    active = json['active'];
    accountType = json['account_type'];
    lang = json['lang'];
    limitCart = json['limit_cart'];
    limitAccount = json['limit_account'];
    limitTransferDay = json['limit_transfer_day'];
    limitTransferManth = json['limit_transfer_manth'];
    limitReceptionDay = json['limit_reception_day'];
    limitReceptionManth = json['limit_reception_manth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_name'] = this.countryName;
    data['phone'] = this.phone;
    data['id_number'] = this.idNumber;
    data['account_number'] = this.accountNumber;
    data['balance'] = this.balance;
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['active'] = this.active;
    data['account_type'] = this.accountType;
    data['lang'] = this.lang;
    data['limit_cart'] = this.limitCart;
    data['limit_account'] = this.limitAccount;
    data['limit_transfer_day'] = this.limitTransferDay;
    data['limit_transfer_manth'] = this.limitTransferManth;
    data['limit_reception_day'] = this.limitReceptionDay;
    data['limit_reception_manth'] = this.limitReceptionManth;
    return data;
  }
}
