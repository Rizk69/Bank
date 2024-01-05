class TransactionModel {
  bool status;
  String message;
  List<Transaction> transactions;

  TransactionModel({
    required this.status,
    required this.message,
    required this.transactions,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    var transactionsList = json['transactions'] as List<dynamic>;
    List<Transaction> transactions =
        transactionsList.map((e) => Transaction.fromJson(e)).toList();

    return TransactionModel(
      status: json['status'],
      message: json['message'],
      transactions: transactions,
    );
  }
}

class Transaction {
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
  String? abbreviation;

  Transaction(
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
      this.abbreviation,
      this.createdAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderImg = json['sender_img'];
    senderID = json['sender_ID'];
    senderFirstName = json['sender_first_name'];
    senderLastName = json['sender_last_name'];
    receiverImg = json['receiver_img'];
    receiverID = json['receiver_ID'];
    receiverFirstName = json['receiver_first_name'];
    receiverLastName = json['receiver_last_name'];
    final dynamic amount = json['final_amount'];
    finalAmount = amount is int ? amount : int.tryParse(amount.toString());
    createdAt = json['created_at'];
    abbreviation = json['abbreviation'];
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
    data['abbreviation'] = this.abbreviation;
    return data;
  }
}

class TransactionDetails {
  int? id;
  String? senderImg;
  String? senderID;
  String? senderFirstName;
  String? senderLastName;
  String? receiverImg;
  String? receiverID;
  String? receiverFirstName;
  String? receiverLastName;
  String? finalAmount;
  String? createdAt;
  String? abbreviation;

  TransactionDetails(
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
      this.createdAt,
      this.abbreviation});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
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
    abbreviation = json['abbreviation'];
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
    data['abbreviation'] = this.abbreviation;

    return data;
  }
}

class CurrencyTransactionDetails {
  int? id;
  String? name;
  String? img;
  String? abbreviation;

  CurrencyTransactionDetails({this.id, this.name, this.img, this.abbreviation});

  CurrencyTransactionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    abbreviation = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['abbreviation'] = this.abbreviation;
    return data;
  }
}