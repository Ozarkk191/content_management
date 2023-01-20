class ContentModel {
  String? contentText;
  String? imageUrl;
  String? contentID;
  String? uid;
  String? fullname;
  String? userUrl;
  int? headerType;

  ContentModel({
    this.contentText,
    this.imageUrl,
    this.contentID,
    this.fullname,
    this.headerType = 0,
    this.uid,
    this.userUrl,
  });

  ContentModel.fromJson(Map<String, dynamic> json) {
    contentText = json['content_text'];
    imageUrl = json['image_url'];
    contentID = json['content_id'];
    uid = json['uid'];
    fullname = json['full_name'];
    userUrl = json['user_url'];
    headerType = json['header_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_text'] = contentText;
    data['image_url'] = imageUrl;
    data['content_id'] = contentID;
    data['uid'] = uid;
    data['full_name'] = fullname;
    data['user_url'] = userUrl;
    data['header_type'] = headerType;
    return data;
  }
}
