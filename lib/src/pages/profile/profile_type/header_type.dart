import 'package:ccm/src/pages/profile/edit_profile_page.dart';
import 'package:ccm/src/pages/profile/profile_type/custom_header_type.dart';
import 'package:ccm/src/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../bloc/user_bloc.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/constant.dart';
import '../../../widgets/header_type/header_custom.dart';
import '../../../widgets/header_type/header_profile.dart';
import '../../../widgets/layouts/main_layout.dart';

class HeaderType extends StatefulWidget {
  final UserModel user;
  final int? oldType;
  const HeaderType({
    super.key,
    required this.user,
    this.oldType,
  });

  @override
  State<HeaderType> createState() => _HeaderTypeState();
}

class _HeaderTypeState extends State<HeaderType> {
  int selectType = 0;

  UserModel userData = UserModel();
  List<int> typeList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

  @override
  void initState() {
    userData = widget.user;

    if (widget.user.headerType == 9999) {
      selectType = widget.user.headerType!;
    } else {
      if (widget.oldType != null) {
        selectType = widget.oldType!;
      }
      selectType = widget.user.headerType!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: appbar(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                width: 3,
                color: fontColor,
              )),
              child: userData.headerCustom != null && selectType == 9999
                  ? HeaderCustom(
                      user: userData,
                      // onEdit: () {},
                    )
                  : HeaderProfile(
                      totalContent: 0,
                      headerType: selectType,
                      user: userData,
                      editProfile: () {},
                    ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "รูปแบบโปรไฟล์",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  MainButton(
                    title: "กำหนดเอง",
                    height: 25,
                    width: 100,
                    fontSize: 10,
                    color: fontColor,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomHeaderType(
                            user: widget.user,
                            oldType: widget.user.headerType ?? 0,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                itemCount: typeList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectType = index;
                      });
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          selectType == index
                              ? const Icon(
                                  Icons.check_box,
                                  color: primaryColor,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey,
                                ),
                          const SizedBox(width: 10),
                          Text("โปรไฟล์รูปแบบที่ $index"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "กำหนดรูปแบบโปรไฟล์",
        style: TextStyle(
          color: fontColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          // userData.
          // log(widget.user.toJson().toString());
          // if (userData.headerCustom != null) {
          //   if (Provider.of<UserData>(context, listen: false)
          //           .user
          //           .headerCustom !=
          //       null) {
          //   } else {
          //     userData.headerType = widget.oldType;
          //     userData.headerCustom = null;
          //   }
          // }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(
                  user: Provider.of<UserData>(context, listen: false).user),
            ),
          );
        },
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fontColor,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            if (userData.headerType != selectType) {
              userData.headerType = selectType;
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(user: userData),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                "ตกลง",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
