class NotificationsModel {
  bool? status;
  String? message;
  List<Notifications>? notifications;

  NotificationsModel({this.status, this.message, this.notifications});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  String? title;
  String? description;
  int? read;
  String? type;
  String? createdAt;
  int? transId;

  Notifications(
      {this.id,
      this.title,
      this.description,
      this.read,
      this.type,
      this.createdAt,
      this.transId});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    read = json['read'];
    type = json['type'];
    createdAt = json['created_at'];
    transId = json['trans_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['read'] = this.read;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['trans_id'] = this.transId;
    return data;
  }
}
