import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/content_model.dart';
import '../../../utils/constant.dart';
import '../avatars/main_avatar.dart';

class SingleCardContent extends StatelessWidget {
  final ContentModel content;
  final Function() onTap;
  const SingleCardContent({
    super.key,
    required this.content,
    required this.onTap,
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
              InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    MainAvatar(imageUrl: content.userUrl, radius: 18),
                    const SizedBox(width: 5),
                    Text(
                      "${content.fullname}",
                      style: TextStyle(
                        color: fontColor.withOpacity(0.9),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
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
          child: content.imageUrl != null
              ? Image.network(
                  content.imageUrl!,
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
                      content.contentText ?? "",
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
                visible: content.contentText != "",
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${content.fullname}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const TextSpan(text: "   "),
                      TextSpan(text: content.contentText ?? ""),
                    ],
                  ),
                ),
              ),
              Text(
                setDateText(content.contentID!),
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
