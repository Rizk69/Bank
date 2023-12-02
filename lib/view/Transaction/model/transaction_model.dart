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
  int id;
  String senderImg;
  String senderID;
  String senderFirstName;
  String senderLastName;
  String receiverImg;
  String receiverID;
  String receiverFirstName;
  String receiverLastName;
  double finalAmount;
  String createdAt;

  Transaction({
    required this.id,
    required this.senderImg,
    required this.senderID,
    required this.senderFirstName,
    required this.senderLastName,
    required this.receiverImg,
    required this.receiverID,
    required this.receiverFirstName,
    required this.receiverLastName,
    required this.finalAmount,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      senderImg: json['sender_img'],
      senderID: json['sender_ID'],
      senderFirstName: json['sender_first_name'],
      senderLastName: json['sender_last_name'],
      receiverImg: json['receiver_img'],
      receiverID: json['receiver_ID'],
      receiverFirstName: json['receiver_first_name'],
      receiverLastName: json['receiver_last_name'],
      finalAmount: (json['final_amount'] is String)
          ? double.tryParse(json['final_amount']) ?? 0.0
          : json['final_amount'].toDouble(),
      createdAt: json['created_at'],
    );
  }
}
