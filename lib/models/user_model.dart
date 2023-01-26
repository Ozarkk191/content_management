import 'package:cloud_firestore/cloud_firestore.dart';

import 'drag_target_item_model.dart';

class UserModel {
  String? email;
  String? firstname;
  String? laststname;
  String? fullName;
  String? imageUrl;
  String? bio;
  String? uid;
  int? headerType;
  DragTargetItemModel? headerCustom;

  UserModel({
    this.email,
    this.firstname,
    this.laststname,
    this.fullName,
    this.imageUrl,
    this.bio,
    this.uid,
    this.headerType = 0,
    this.headerCustom,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    laststname = json['laststname'];
    fullName = json['full_name'];
    imageUrl = json['image_url'];
    bio = json['bio'];
    uid = json['uid'];
    headerType = json['header_type'];
    headerCustom = json['header_custom'] != null
        ? DragTargetItemModel.fromJson(json['header_custom'])
        : null;
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstname': firstname,
      'laststname': laststname,
      'full_name': fullName,
      'image_url': imageUrl,
      'bio': bio,
      'uid': uid,
      'header_type': headerType,
      'header_custom': headerCustom?.toMap(),
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : email = doc.data()?["email"],
        firstname = doc.data()?["firstname"],
        laststname = doc.data()?["laststname"],
        fullName = doc.data()?["full_name"],
        imageUrl = doc.data()?["image_url"],
        bio = doc.data()?["bio"],
        uid = doc.data()?["uid"],
        headerType = doc.data()?["header_type"],
        headerCustom =
            DragTargetItemModel.fromJson(doc.data()?["header_custom"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstname'] = firstname;
    data['laststname'] = laststname;
    data['full_name'] = fullName;
    data['image_url'] = imageUrl;
    data['bio'] = bio;
    data['uid'] = uid;
    data['header_type'] = headerType;
    data['header_custom'] = headerCustom;
    return data;
  }
}
