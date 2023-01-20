import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/content_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../avatars/main_avatar.dart';

class ContentCard extends StatelessWidget {
  final UserModel user;
  final List<ContentModel> list;
  final int index;
  const ContentCard({
    super.key,
    required this.user,
    required this.list,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MainAvatar(imageUrl: user.imageUrl, radius: 18),
                  const SizedBox(width: 5),
                  Text(
                    "${user.fullName}",
                    style: TextStyle(
                      color: fontColor.withOpacity(0.9),
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Icon(
                FontAwesomeIcons.ellipsis,
                size: 18,
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: list[index].imageUrl != null
              ? Image.network(
                  list[index].imageUrl!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      list[index].contentText ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20),
                      maxLines: 10,
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: list[index].contentText != "",
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${user.fullName}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const TextSpan(text: "   "),
                      TextSpan(text: list[index].contentText ?? ""),
                    ],
                  ),
                ),
              ),
              Text(
                setDateText(list[index].contentID!),
                style: TextStyle(
                  color: fontColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String setDateText(String dateText) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(dateText));
    List<String> mouthList = [
      "มกราคม",
      "กุมภาพันธ์",
      "มีนาคม",
      "เมษายน",
      "พฤษภาคม",
      "มิถุนายน",
      "กรกฎาคม",
      "สิงหาคม",
      "กันยายน",
      "ตุลาคม",
      "พฤศจิกายน",
      "ธันวาคม",
    ];
    return "${date.day} ${mouthList[date.month - 1]} ${date.year + 543}";
  }
}
