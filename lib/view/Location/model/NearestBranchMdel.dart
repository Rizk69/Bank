// nearest_branch_model.dart

class NearestBranchModel {
  bool? status;
  String? message;
  NearestBranch? nearestBranch;
  List<NearestBranch>? nearestBranches;

  NearestBranchModel({
    this.status,
    this.message,
    this.nearestBranch,
    this.nearestBranches,
  });

  NearestBranchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    nearestBranch = json['nearestBranch'] != null
        ? NearestBranch.fromJson(json['nearestBranch'])
        : null;
    if (json['nearestBranches'] != null) {
      nearestBranches = <NearestBranch>[];
      json['nearestBranches'].forEach((v) {
        nearestBranches!.add(NearestBranch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (nearestBranch != null) {
      data['nearestBranch'] = nearestBranch!.toJson();
    }
    if (nearestBranches != null) {
      data['nearestBranches'] =
          nearestBranches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// nearest_branch.dart

class NearestBranch {
  int? id;
  double? distance;
  double? latitude;
  double? longitude;
  String? name;
  String? title;

  NearestBranch({
    this.id,
    this.distance,
    this.latitude,
    this.longitude,
    this.name,
    this.title,
  });

  NearestBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distance = json['distance'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['distance'] = distance;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['title'] = title;
    return data;
  }
}
