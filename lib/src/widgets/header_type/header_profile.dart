import 'package:ccm/src/widgets/header_type/header_menu.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../avatars/main_avatar.dart';

class HeaderProfile extends StatelessWidget {
  final UserModel user;
  final int totalContent;
  final int headerType;
  const HeaderProfile({
    super.key,
    required this.user,
    required this.totalContent,
    this.headerType = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (headerType == 0) ...[
          type0(),
        ] else if (headerType == 1) ...[
          type1(),
        ] else if (headerType == 2) ...[
          type2(),
        ] else if (headerType == 3) ...[
          type3(),
        ] else if (headerType == 4) ...[
          type4(),
        ] else if (headerType == 5) ...[
          type5(),
        ] else if (headerType == 6) ...[
          type6(),
        ] else if (headerType == 7) ...[
          type7(),
        ] else if (headerType == 8) ...[
          type8(),
        ] else if (headerType == 9) ...[
          type9(),
        ],
      ],
    );
  }

  Widget type0() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MainAvatar(imageUrl: user.imageUrl, radius: 30),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HeaderMenu(
                    title: "Post",
                    value: "$totalContent",
                  ),
                  const HeaderMenu(
                    title: "Follower",
                    value: "0",
                  ),
                  const HeaderMenu(
                    title: "Folloing",
                    value: "0",
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "${user.fullName}",
          style: TextStyle(
            color: fontColor.withOpacity(0.9),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
      ],
    );
  }

  Widget type1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MainAvatar(imageUrl: user.imageUrl, radius: 30),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.fullName}",
                  style: TextStyle(
                    color: fontColor.withOpacity(0.9),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
              ],
            ),

            // const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
          ],
        ),
      ],
    );
  }

  Widget type2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MainAvatar(imageUrl: user.imageUrl, radius: 30),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
          ],
        ),
      ],
    );
  }

  Widget type3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
          ],
        ),
        const SizedBox(height: 10),
        MainAvatar(imageUrl: user.imageUrl, radius: 30),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
      ],
    );
  }

  Widget type4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
          ],
        ),
        const SizedBox(height: 10),
        MainAvatar(imageUrl: user.imageUrl, radius: 30),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
      ],
    );
  }

  Widget type5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MainAvatar(imageUrl: user.imageUrl, radius: 30),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
      ],
    );
  }

  Widget type6() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAvatar(imageUrl: user.imageUrl, radius: 30),
            const SizedBox(height: 10),
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
          ],
        ),
      ],
    );
  }

  Widget type7() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAvatar(imageUrl: user.imageUrl, radius: 30),
            const SizedBox(height: 10),
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
      ],
    );
  }

  Widget type8() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAvatar(imageUrl: user.imageUrl, radius: 30),
            const SizedBox(height: 10),
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
          ],
        ),
      ],
    );
  }

  Widget type9() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderMenu(
              title: "Post",
              value: "$totalContent",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Follower",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
            const HeaderMenu(
              title: "Folloing",
              value: "0",
              headerMenuType: HeaderMenuType.horizontal,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAvatar(imageUrl: user.imageUrl, radius: 30),
            const SizedBox(height: 10),
            Text(
              "${user.fullName}",
              style: TextStyle(
                color: fontColor.withOpacity(0.9),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
      ],
    );
  }

  Text textBox(
    String text, {
    FontWeight? fontWeight,
    double fontSize = 14,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: fontColor.withOpacity(0.9),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
