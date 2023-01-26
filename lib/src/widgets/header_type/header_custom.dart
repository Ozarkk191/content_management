import 'package:ccm/models/user_model.dart';
import 'package:ccm/src/widgets/buttons/main_button.dart';
import 'package:ccm/src/widgets/header_type/header_menu.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class HeaderCustom extends StatelessWidget {
  final UserModel user;
  final Function()? onEdit;
  final int? totalPost;
  const HeaderCustom({
    super.key,
    required this.user,
    this.onEdit,
    this.totalPost = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: Stack(
            children: [
              Align(
                alignment: setAlign(
                    alignment: user.headerCustom!.profile!.position ?? ""),
                child: avatarBox(
                  borderRadius: user.headerCustom!.profile!.borderRadius,
                  size: user.headerCustom!.profile!.size!,
                  imageUrl: user.imageUrl,
                ),
              ),
              Align(
                alignment: setAlign(
                    alignment: user.headerCustom!.name!.position ?? ""),
                child: nameBoxCheck(),
              ),
              Align(
                alignment: setAlign(
                    alignment: user.headerCustom!.status!.position ?? ""),
                child: statusBoxCheck(context),
              )
            ],
          ),
        ),
        Visibility(
          visible: onEdit != null,
          child: MainButton(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 30,
            fontSize: 10,
            color: fontColor.withOpacity(0.9),
            borderRadius: 10,
            title: "แก้ไขโปรไฟล์",
            onTap: onEdit,
          ),
        ),
      ],
    );
  }

  Widget avatarBox({
    double size = 30,
    double? borderRadius,
    String? imageUrl,
  }) {
    return Container(
      width: size * 2,
      height: size * 2,
      padding: const EdgeInsets.all(3),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.circular(50),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.circular(50),
        ),
        child: imageUrl == null
            ? Image.asset("assets/icons/icon_app.png")
            : Image.network(
                width: size * 2,
                height: size * 2,
                imageUrl,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget nameBoxCheck() {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          if (user.headerCustom!.name!.type == 1) ...[
            nameBox(),
          ] else if (user.headerCustom!.name!.type == 2) ...[
            nameBox(
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ] else if (user.headerCustom!.name!.type == 3) ...[
            nameBox(
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ] else ...[
            nameBox(),
          ]
        ],
      ),
    );
  }

  Widget statusBoxCheck(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          if (user.headerCustom!.status!.type == 1) ...[
            statusBox(context),
          ] else if (user.headerCustom!.status!.type == 2) ...[
            statusBox(context, headerMenuType: HeaderMenuType.verticalRevease),
          ] else ...[
            statusBox(context),
          ]
        ],
      ),
    );
  }

  Widget nameBox({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    bool vertical = true,
    bool revease = false,
  }) {
    return SizedBox(
      height: 80,
      child: vertical
          ? Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (revease) ...[
                  textBox("${user.bio}", fontSize: 12),
                  textBox("${user.fullName}", fontWeight: FontWeight.w600),
                ] else ...[
                  textBox("${user.fullName}", fontWeight: FontWeight.w600),
                  textBox("${user.bio}", fontSize: 12),
                ]
              ],
            )
          : Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (revease) ...[
                  textBox("${user.bio}", fontSize: 12),
                  textBox("${user.fullName}", fontWeight: FontWeight.w600),
                ] else ...[
                  textBox("${user.fullName}", fontWeight: FontWeight.w600),
                  textBox("${user.bio}", fontSize: 12),
                ]
              ],
            ),
    );
  }

  Text textBox(
    String text, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "narrow",
        color: fontColor,
        decoration: TextDecoration.none,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget statusBox(
    BuildContext context, {
    HeaderMenuType headerMenuType = HeaderMenuType.vertical,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderMenu(
            title: "Post",
            value: "$totalPost",
            headerMenuType: headerMenuType,
          ),
          HeaderMenu(
            title: "Follower",
            value: "0",
            headerMenuType: headerMenuType,
          ),
          HeaderMenu(
            title: "Folloing",
            value: "0",
            headerMenuType: headerMenuType,
          ),
        ],
      ),
    );
  }

  Alignment setAlign({required String alignment}) {
    switch (alignment) {
      case "bottomCenter":
        return Alignment.bottomCenter;
      case "bottomLeft":
        return Alignment.bottomLeft;
      case "bottomRight":
        return Alignment.bottomRight;
      case "topLeft":
        return Alignment.topLeft;
      case "topCenter":
        return Alignment.topCenter;
      case "topRight":
        return Alignment.topRight;
      default:
        return Alignment.bottomCenter;
    }
  }
}
