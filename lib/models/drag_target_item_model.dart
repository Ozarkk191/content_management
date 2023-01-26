import 'package:cloud_firestore/cloud_firestore.dart';

class DragTargetItemModel {
  ProfileProperty? profile;
  NameProperty? name;
  NameProperty? status;

  DragTargetItemModel({
    this.profile,
    this.name,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'profile': profile?.toMap(),
      'name': name?.toMap(),
      'status': status?.toMap(),
    };
  }

  DragTargetItemModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : profile = ProfileProperty.fromJson(doc.data()?["profile"]),
        name = NameProperty.fromJson(doc.data()?["name"]),
        status = NameProperty.fromJson(doc.data()?["status"]);

  DragTargetItemModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'] != null
        ? ProfileProperty.fromJson(json['profile'])
        : null;
    name = json['name'] != null ? NameProperty.fromJson(json['name']) : null;
    status =
        json['status'] != null ? NameProperty.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    return data;
  }
}

class ProfileProperty {
  String? position;
  double? size;
  double? borderRadius;

  ProfileProperty({this.position, this.borderRadius, this.size});

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'size': size,
      'borderRadius': borderRadius,
    };
  }

  ProfileProperty.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : position = doc.data()?["position"],
        size = doc.data()?["size"],
        borderRadius = doc.data()?["borderRadius"];

  ProfileProperty.fromJson(Map<String, dynamic> json) {
    borderRadius = json['borderRadius'];
    size = json['size'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['borderRadius'] = borderRadius;
    data['size'] = size;
    data['position'] = position;
    return data;
  }
}

class NameProperty {
  String? position;
  int? type;

  NameProperty({this.position, this.type});

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'type': type,
    };
  }

  NameProperty.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : position = doc.data()?["position"],
        type = doc.data()?["type"];

  NameProperty.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['position'] = position;
    return data;
  }
}
