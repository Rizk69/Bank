class ApiResponseCheck {
  final bool status;
  final String message;
  final List<UserData> user;

  ApiResponseCheck({
    required this.status,
    required this.message,
    required this.user,
  });

  factory ApiResponseCheck.fromJson(Map<String, dynamic> json) {
    List<UserData> userList = [];
    if (json['user'] != null) {
      userList = List.from(json['user'])
          .map((userJson) => UserData.fromJson(userJson))
          .toList();
    }

    return ApiResponseCheck(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      user: userList,
    );
  }
}

class UserData {
  final bool statusPhone;
  final String phone;
  final UserDetails? user;

  UserData({
    required this.phone,
    required this.statusPhone,
    this.user,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      statusPhone: json['status_phone'] ?? false,
      phone: json['phone'] ?? false,
      user: json['user'] != null ? UserDetails.fromJson(json['user']) : null,
    );
  }
}

class UserDetails {
  final int id;
  final dynamic
      img; // Assuming img can be either null or a String, you may need to adjust this based on the actual data type
  final String firstName;
  final String lastName;
  final String phone;

  UserDetails({
    required this.id,
    required this.img,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? 0,
      img: json['img'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
