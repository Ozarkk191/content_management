class UserModel {
  String? email;
  String? firstname;
  String? laststname;
  String? fullName;
  String? imageUrl;
  String? bio;
  String? uid;
  int? headerType;
  int? contentType;

  UserModel({
    this.email,
    this.firstname,
    this.laststname,
    this.fullName,
    this.imageUrl,
    this.bio,
    this.uid,
    this.contentType = 0,
    this.headerType = 0,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    laststname = json['laststname'];
    fullName = json['full_name'];
    imageUrl = json['image_url'];
    bio = json['bio'];
    uid = json['uid'];
    contentType = json['content_type'];
    headerType = json['header_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstname'] = firstname;
    data['laststname'] = laststname;
    data['full_name'] = fullName;
    data['image_url'] = imageUrl;
    data['bio'] = bio;
    data['uid'] = uid;
    data['content_type'] = contentType;
    data['header_type'] = headerType;
    return data;
  }
}
