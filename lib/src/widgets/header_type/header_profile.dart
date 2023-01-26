import 'package:ccm/src/widgets/buttons/main_button.dart';
import 'package:ccm/src/widgets/header_type/header_menu.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../utils/constant.dart';
import '../avatars/main_avatar.dart';

class HeaderProfile extends StatelessWidget {
  final UserModel user;
  final int totalContent;
  final int headerType;
  final bool isOther;

  final Function() editProfile;
  const HeaderProfile({
    super.key,
    required this.user,
    required this.totalContent,
    this.headerType = 0,
    required this.editProfile,
    this.isOther = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (headerType == 0) ...[
          type0(context),
        ] else if (headerType == 1) ...[
          type1(context),
        ] else if (headerType == 2) ...[
          type2(context),
        ] else if (headerType == 3) ...[
          type3(context),
        ] else if (headerType == 4) ...[
          type4(context),
        ] else if (headerType == 5) ...[
          type5(context),
        ] else if (headerType == 6) ...[
          type6(context),
        ] else if (headerType == 7) ...[
          type7(context),
        ] else if (headerType == 8) ...[
          type8(context),
        ] else if (headerType == 9) ...[
          type9(context),
        ] else if (headerType == 10) ...[
          type10(context),
        ] else if (headerType == 11) ...[
          type11(context),
        ] else if (headerType == 12) ...[
          type12(context),
        ] else if (headerType == 13) ...[
          type13(context),
        ],
      ],
    );
  }

  Widget type0(context) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Visibility(
              visible: !isOther,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 10),
                  MainButton(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 30,
                    fontSize: 10,
                    color: fontColor.withOpacity(0.9),
                    borderRadius: 10,
                    title: "แก้ไขโปรไฟล์",
                    onTap: editProfile,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget type1(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
            Visibility(
              visible: !isOther,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainButton(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 25,
                    fontSize: 9,
                    color: fontColor.withOpacity(0.9),
                    borderRadius: 10,
                    title: "แก้ไขโปรไฟล์",
                    onTap: editProfile,
                  ),
                ],
              ),
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

  Widget type2(context) {
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
        const SizedBox(height: 5),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type3(context) {
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
        const SizedBox(height: 5),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type4(context) {
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
        const SizedBox(height: 5),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type5(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(height: 5),
            Visibility(
              visible: !isOther,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainButton(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 30,
                    fontSize: 10,
                    color: fontColor.withOpacity(0.9),
                    borderRadius: 10,
                    title: "แก้ไขโปรไฟล์",
                    onTap: editProfile,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
          ],
        ),
      ],
    );
  }

  Widget type6(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: MainAvatar(
                imageUrl: user.imageUrl,
                borderRadius: 15,
                border: 0,
                radius: 40,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
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
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type7(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MainAvatar(
          imageUrl: user.imageUrl,
          borderRadius: 15,
          border: 2,
          radius: 40,
        ),
        const SizedBox(height: 10),
        Text(
          "${user.fullName}",
          style: TextStyle(
            color: fontColor.withOpacity(0.9),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        textBox(user.bio ?? "คำอธิบายตัวตน", fontSize: 14),
        const SizedBox(height: 10),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type8(context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.black,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 15),
                  MainAvatar(
                    imageUrl: user.imageUrl,
                    border: 2,
                    radius: 40,
                  ),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HeaderMenu(
                            title: "Post",
                            value: "$totalContent",
                            color: Colors.white,
                          ),
                          const HeaderMenu(
                            title: "Follower",
                            value: "0",
                            color: Colors.white,
                          ),
                          const HeaderMenu(
                            title: "Folloing",
                            value: "0",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !isOther,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MainButton(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 30,
                            fontSize: 10,
                            color: fontColor.withOpacity(0.9),
                            borderRadius: 10,
                            title: "แก้ไขโปรไฟล์",
                            onTap: editProfile,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget type9(context) {
    return SizedBox(
      height: 160,
      child: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HeaderMenu(
                    title: "Post",
                    value: "$totalContent",
                    color: Colors.white,
                  ),
                  const HeaderMenu(
                    title: "Follower",
                    value: "0",
                    color: Colors.white,
                  ),
                  const HeaderMenu(
                    title: "Folloing",
                    value: "0",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MainAvatar(
                      imageUrl: user.imageUrl,
                      border: 2,
                      radius: 35,
                    ),
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
                    )
                  ],
                ),
                Visibility(
                  visible: !isOther,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainButton(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 25,
                        fontSize: 10,
                        color: fontColor.withOpacity(0.9),
                        borderRadius: 10,
                        title: "แก้ไขโปรไฟล์",
                        onTap: editProfile,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget type10(context) {
    return Column(
      children: [
        Row(
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
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type11(context) {
    return Column(
      children: [
        Row(
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
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type12(context) {
    return Column(
      children: [
        Row(
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
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget type13(context) {
    return Column(
      children: [
        Row(
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
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: !isOther,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 30,
                fontSize: 10,
                color: fontColor.withOpacity(0.9),
                borderRadius: 10,
                title: "แก้ไขโปรไฟล์",
                onTap: editProfile,
              ),
            ],
          ),
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
