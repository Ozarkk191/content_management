import 'dart:convert';
import 'package:ccm/models/drag_target_item_model.dart';
import 'package:ccm/models/user_model.dart';
import 'package:ccm/src/pages/profile/profile_type/header_type.dart';
import 'package:ccm/src/widgets/layouts/main_layout.dart';
import 'package:ccm/utils/constant.dart';
import 'package:flutter/material.dart';

import '../../../widgets/header_type/header_menu.dart';

class CustomHeaderType extends StatefulWidget {
  final UserModel user;
  final int oldType;
  const CustomHeaderType({
    super.key,
    required this.user,
    required this.oldType,
  });

  @override
  State<CustomHeaderType> createState() => _CustomHeaderTypeState();
}

class _CustomHeaderTypeState extends State<CustomHeaderType> {
  DragTargetItemModel position1 = DragTargetItemModel();
  DragTargetItemModel position2 = DragTargetItemModel();
  DragTargetItemModel position3 = DragTargetItemModel();
  DragTargetItemModel position4 = DragTargetItemModel();
  DragTargetItemModel position5 = DragTargetItemModel();
  DragTargetItemModel position6 = DragTargetItemModel();

  UserModel userData = UserModel();
  bool loading = false;

  String menuSelected = "รูปโปรไฟล์";

  @override
  void initState() {
    userData = widget.user;
    super.initState();
  }

  void onResetProfil() {
    position1.profile = null;
    position2.profile = null;
    position3.profile = null;
    position4.profile = null;
    position5.profile = null;
    position6.profile = null;
  }

  void onResetName() {
    position1.name = null;
    position2.name = null;
    position3.name = null;
    position4.name = null;
    position5.name = null;
    position6.name = null;
  }

  void onResetStatus() {
    position1.status = null;
    position2.status = null;
    position3.status = null;
    position4.status = null;
    position5.status = null;
    position6.status = null;
  }

  void onSave(context) {
    DragTargetItemModel data = DragTargetItemModel();
    List<DragTargetItemModel> dataList = [];
    dataList.add(position1);
    dataList.add(position2);
    dataList.add(position3);
    dataList.add(position4);
    dataList.add(position5);
    dataList.add(position6);

    for (var i = 0; i < dataList.length; i++) {
      if (dataList[i].profile != null) {
        data.profile = dataList[i].profile;
      }
      if (dataList[i].name != null) {
        data.name = dataList[i].name;
      }
      if (dataList[i].status != null) {
        data.status = dataList[i].status;
      }
    }
    userData.headerType = 9999;
    userData.headerCustom = data;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HeaderType(
          user: userData,
          oldType: widget.oldType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          "กำหนดเอง",
          style: TextStyle(
            color: fontColor,
            fontSize: 18,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HeaderType(
                  user: widget.user,
                  oldType: widget.oldType,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: fontColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () => onSave(context),
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
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: MediaQuery.of(context).size.width - 20,
              height: 190,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                ),
              ),
              child: Stack(
                children: [
                  target(
                    alignment: Alignment.topLeft,
                    model: position1,
                    onAccept: (details) {
                      final data = jsonEncode(details.data);
                      DragTargetItemModel detail =
                          DragTargetItemModel.fromJson(jsonDecode(data));

                      if (detail.profile != null) {
                        if (position1.profile == null &&
                            position1.name == null &&
                            position1.status == null) {
                          onResetProfil();
                          position1 = detail;
                          position1.profile!.position = "topLeft";
                        } else if (position1.profile != null) {
                          onResetProfil();
                          position1 = detail;
                          position1.profile!.position = "topLeft";
                        }
                      } else if (detail.name != null) {
                        if (position1.profile == null &&
                            position1.name == null &&
                            position1.status == null) {
                          onResetName();
                          position1 = detail;
                          position1.name!.position = "topLeft";
                        } else if (position1.name != null) {
                          onResetName();
                          position1 = detail;
                          position1.name!.position = "topLeft";
                        }
                      } else if (detail.status != null) {
                        if (position1.profile == null &&
                            position1.name == null &&
                            position1.status == null) {
                          onResetStatus();
                          position1 = detail;
                          position1.status!.position = "topLeft";
                        } else if (position1.status != null) {
                          onResetStatus();
                          position1 = detail;
                          position1.status!.position = "topLeft";
                        }
                      }
                      setState(() {});
                    },
                  ),
                  target(
                    alignment: Alignment.topCenter,
                    model: position2,
                    onAccept: (details) {
                      final data = jsonEncode(details.data);
                      DragTargetItemModel detail =
                          DragTargetItemModel.fromJson(jsonDecode(data));

                      if (detail.profile != null) {
                        if (position2.profile == null &&
                            position2.name == null &&
                            position2.status == null) {
                          onResetProfil();
                          position2 = detail;
                          position2.profile!.position = "topCenter";
                        } else if (position2.profile != null) {
                          onResetProfil();
                          position2 = detail;
                          position2.profile!.position = "topCenter";
                        }
                      } else if (detail.name != null) {
                        if (position2.profile == null &&
                            position2.name == null &&
                            position2.status == null) {
                          onResetName();
                          position2 = detail;
                          position2.name!.position = "topCenter";
                        } else if (position2.name != null) {
                          onResetName();
                          position2 = detail;
                          position2.name!.position = "topCenter";
                        }
                      } else if (detail.status != null) {
                        if (position2.profile == null &&
                            position2.name == null &&
                            position2.status == null) {
                          onResetStatus();
                          position2 = detail;
                          position2.status!.position = "topCenter";
                        } else if (position2.status != null) {
                          onResetStatus();
                          position2 = detail;
                          position2.status!.position = "topCenter";
                        }
                      }
                      setState(() {});
                    },
                  ),
                  target(
                    alignment: Alignment.topRight,
                    model: position3,
                    onAccept: (details) {
                      final data = jsonEncode(details.data);
                      DragTargetItemModel detail =
                          DragTargetItemModel.fromJson(jsonDecode(data));
                      if (detail.profile != null) {
                        if (position3.profile == null &&
                            position3.name == null &&
                            position3.status == null) {
                          onResetProfil();
                          position3 = detail;
                          position3.profile!.position = "topRight";
                        } else if (position3.profile != null) {
                          onResetProfil();
                          position3 = detail;
                          position3.profile!.position = "topRight";
                        }
                      } else if (detail.name != null) {
                        if (position3.profile == null &&
                            position3.name == null &&
                            position3.status == null) {
                          onResetName();
                          position3 = detail;
                          position3.name!.position = "topRight";
                        } else if (position3.name != null) {
                          onResetName();
                          position3 = detail;
                          position3.name!.position = "topRight";
                        }
                      } else if (detail.status != null) {
                        if (position3.profile == null &&
                            position3.name == null &&
                            position3.status == null) {
                          onResetStatus();
                          position3 = detail;
                          position3.status!.position = "topRight";
                        } else if (position3.status != null) {
                          onResetStatus();
                          position3 = detail;
                          position3.status!.position = "topRight";
                        }
                      }
                      setState(() {});
                    },
                  ),
                  target(
                    alignment: Alignment.bottomLeft,
                    model: position4,
                    onAccept: (details) {
                      final data = jsonEncode(details.data);
                      DragTargetItemModel detail =
                          DragTargetItemModel.fromJson(jsonDecode(data));
                      if (detail.profile != null) {
                        if (position4.profile == null &&
                            position4.name == null &&
                            position4.status == null) {
                          onResetProfil();
                          position4 = detail;
                          position4.profile!.position = "bottomLeft";
                        } else if (position4.profile != null) {
                          onResetProfil();
                          position4 = detail;
                          position4.profile!.position = "bottomLeft";
                        }
                      } else if (detail.name != null) {
                        if (position4.profile == null &&
                            position4.name == null &&
                            position4.status == null) {
                          onResetName();
                          position4 = detail;
                          position4.name!.position = "bottomLeft";
                        } else if (position4.name != null) {
                          onResetName();
                          position4 = detail;
                          position4.name!.position = "bottomLeft";
                        }
                      } else if (detail.status != null) {
                        if (position4.profile == null &&
                            position4.name == null &&
                            position4.status == null) {
                          onResetStatus();
                          position4 = detail;
                          position4.status!.position = "bottomLeft";
                        } else if (position4.status != null) {
                          onResetStatus();
                          position4 = detail;
                          position4.status!.position = "bottomLeft";
                        }
                      }
                      setState(() {});
                    },
                  ),
                  target(
                    alignment: Alignment.bottomCenter,
                    model: position5,
                    onAccept: (details) {
                      final data = jsonEncode(details.data);
                      DragTargetItemModel detail =
                          DragTargetItemModel.fromJson(jsonDecode(data));
                      if (detail.profile != null) {
                        if (position5.profile == null &&
                            position5.name == null &&
                            position5.status == null) {
                          onResetProfil();
                          position5 = detail;
                          position5.profile!.position = "bottomCenter";
                        } else if (position5.profile != null) {
                          onResetProfil();
                          position5 = detail;
                          position5.profile!.position = "bottomCenter";
                        }
                      } else if (detail.name != null) {
                        if (position5.profile == null &&
                            position5.name == null &&
                            position5.status == null) {
                          onResetName();
                          position5 = detail;
                          position5.name!.position = "bottomCenter";
                        } else if (position5.name != null) {
                          onResetName();
                          position5 = detail;
                          position5.name!.position = "bottomCenter";
                        }
                      } else if (detail.status != null) {
                        if (position5.profile == null &&
                            position5.name == null &&
                            position5.status == null) {
                          onResetStatus();
                          position5 = detail;
                          position5.status!.position = "bottomCenter";
                        } else if (position5.status != null) {
                          onResetStatus();
                          position5 = detail;
                          position5.status!.position = "bottomCenter";
                        }
                      }
                      setState(() {});
                    },
                  ),
                  target(
                    alignment: Alignment.bottomRight,
                    model: position6,
                    onAccept: (details) {
                      final data = jsonEncode(details.data);
                      DragTargetItemModel detail =
                          DragTargetItemModel.fromJson(jsonDecode(data));
                      if (detail.profile != null) {
                        if (position6.profile == null &&
                            position6.name == null &&
                            position6.status == null) {
                          onResetProfil();
                          position6 = detail;
                          position6.profile!.position = "bottomRight";
                        } else if (position6.profile != null) {
                          onResetProfil();
                          position6 = detail;
                          position6.profile!.position = "bottomRight";
                        }
                      } else if (detail.name != null) {
                        if (position6.profile == null &&
                            position6.name == null &&
                            position6.status == null) {
                          onResetName();
                          position6 = detail;
                          position6.name!.position = "bottomRight";
                        } else if (position6.name != null) {
                          onResetName();
                          position6 = detail;
                          position6.name!.position = "bottomRight";
                        }
                      } else if (detail.status != null) {
                        if (position6.profile == null &&
                            position6.name == null &&
                            position6.status == null) {
                          onResetStatus();
                          position6 = detail;
                          position6.status!.position = "bottomRight";
                        } else if (position6.status != null) {
                          onResetStatus();
                          position6 = detail;
                          position6.status!.position = "bottomRight";
                        }
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Visibility(
                        visible: menuSelected == "รูปโปรไฟล์",
                        child: profileImageDrag(),
                      ),
                      Visibility(
                        visible: menuSelected == "ชื่อและคำอธิบาย",
                        child: nameDrag(),
                      ),
                      Visibility(
                        visible: menuSelected == "สถานะ",
                        child: statusDrag(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                tapMenu(
                  context,
                  title: "รูปโปรไฟล์",
                  active: menuSelected == "รูปโปรไฟล์",
                  onTap: () {
                    setState(() {
                      menuSelected = "รูปโปรไฟล์";
                    });
                  },
                ),
                tapMenu(
                  context,
                  title: "ชื่อและคำอธิบาย",
                  active: menuSelected == "ชื่อและคำอธิบาย",
                  onTap: () {
                    setState(() {
                      menuSelected = "ชื่อและคำอธิบาย";
                    });
                  },
                ),
                tapMenu(
                  context,
                  title: "สถานะ",
                  active: menuSelected == "สถานะ",
                  onTap: () {
                    setState(() {
                      menuSelected = "สถานะ";
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  SizedBox statusDrag(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Draggable(
            feedback: statusBox(),
            childWhenDragging: box(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 52,
                child: Container()),
            data: DragTargetItemModel(
              status: NameProperty(
                type: 1,
              ),
            ).toJson(),
            child: box(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 52,
              child: statusBox(),
            ),
          ),
          const SizedBox(height: 10),
          Draggable(
            feedback: statusBox(
              headerMenuType: HeaderMenuType.verticalRevease,
            ),
            childWhenDragging: box(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 52,
                child: Container()),
            data: DragTargetItemModel(
              status: NameProperty(
                type: 2,
              ),
            ).toJson(),
            child: box(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 52,
              child: statusBox(
                headerMenuType: HeaderMenuType.verticalRevease,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameDrag() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Draggable(
                feedback: nameBox(),
                childWhenDragging: box(child: Container()),
                data: DragTargetItemModel(
                  name: NameProperty(
                    type: 1,
                  ),
                ).toJson(),
                child: box(
                  child: nameBox(),
                ),
              ),
              Draggable(
                feedback: nameBox(
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                childWhenDragging: box(child: Container()),
                data: DragTargetItemModel(
                  name: NameProperty(
                    type: 2,
                  ),
                ).toJson(),
                child: box(
                  child: nameBox(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ),
              Draggable(
                feedback: nameBox(
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
                childWhenDragging: box(child: Container()),
                data: DragTargetItemModel(
                  name: NameProperty(
                    type: 3,
                  ),
                ).toJson(),
                child: box(
                  child: nameBox(
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container box({Widget? child, double? width, double height = 100}) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: width ?? MediaQuery.of(context).size.width * 0.29,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: child,
      ),
    );
  }

  Column profileImageDrag() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              feedback: avatarBox(
                imageUrl: userData.imageUrl,
                size: 30,
              ),
              childWhenDragging: box(child: Container()),
              data: DragTargetItemModel(
                profile: ProfileProperty(
                  size: 30,
                ),
              ).toJson(),
              child: box(
                child: avatarBox(
                  imageUrl: userData.imageUrl,
                  size: 30,
                ),
              ),
            ),
            Draggable(
              feedback: avatarBox(
                imageUrl: userData.imageUrl,
                size: 35,
              ),
              childWhenDragging: box(child: Container()),
              data: DragTargetItemModel(
                profile: ProfileProperty(
                  size: 35,
                ),
              ).toJson(),
              child: box(
                child: avatarBox(
                  imageUrl: userData.imageUrl,
                  size: 35,
                ),
              ),
            ),
            Draggable(
              feedback: avatarBox(
                imageUrl: userData.imageUrl,
                size: 40,
              ),
              childWhenDragging: box(child: Container()),
              data: DragTargetItemModel(
                profile: ProfileProperty(
                  size: 40,
                ),
              ).toJson(),
              child: box(
                child: avatarBox(
                  imageUrl: userData.imageUrl,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              feedback: avatarBox(
                imageUrl: userData.imageUrl,
                size: 30,
                borderRadius: 10,
              ),
              childWhenDragging: box(child: Container()),
              data: DragTargetItemModel(
                profile: ProfileProperty(
                  borderRadius: 10,
                  size: 30,
                ),
              ).toJson(),
              child: box(
                child: avatarBox(
                  imageUrl: userData.imageUrl,
                  size: 30,
                  borderRadius: 10,
                ),
              ),
            ),
            Draggable(
              feedback: avatarBox(
                imageUrl: userData.imageUrl,
                size: 35,
                borderRadius: 10,
              ),
              childWhenDragging: box(child: Container()),
              data: DragTargetItemModel(
                profile: ProfileProperty(
                  borderRadius: 10,
                  size: 35,
                ),
              ).toJson(),
              child: box(
                child: avatarBox(
                  imageUrl: userData.imageUrl,
                  size: 35,
                  borderRadius: 10,
                ),
              ),
            ),
            Draggable(
              feedback: avatarBox(
                imageUrl: userData.imageUrl,
                size: 40,
                borderRadius: 10,
              ),
              childWhenDragging: box(child: Container()),
              data: DragTargetItemModel(
                profile: ProfileProperty(
                  borderRadius: 10,
                  size: 40,
                ),
              ).toJson(),
              child: box(
                child: avatarBox(
                  imageUrl: userData.imageUrl,
                  size: 40,
                  borderRadius: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Align target({
    required Alignment alignment,
    required DragTargetItemModel model,
    required Function(DragTargetDetails details) onAccept,
  }) {
    return Align(
      alignment: alignment,
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Stack(
            children: checkTarget(model),
          );
        },
        onAcceptWithDetails: onAccept,
      ),
    );
  }

  InkWell tapMenu(
    BuildContext context, {
    required String title,
    required Function() onTap,
    bool active = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: 30,
        decoration: BoxDecoration(
          color: active ? primaryColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.white : fontColor,
            ),
          ),
        ),
      ),
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
                  textBox("${userData.bio}", fontSize: 10),
                  textBox("${userData.fullName}", fontWeight: FontWeight.w600),
                ] else ...[
                  textBox("${userData.fullName}", fontWeight: FontWeight.w600),
                  textBox("${userData.bio}", fontSize: 10),
                ]
              ],
            )
          : Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (revease) ...[
                  textBox("${userData.bio}", fontSize: 10),
                  textBox("${userData.fullName}", fontWeight: FontWeight.w600),
                ] else ...[
                  textBox("${userData.fullName}", fontWeight: FontWeight.w600),
                  textBox("${userData.bio}", fontSize: 10),
                ]
              ],
            ),
    );
  }

  Text textBox(
    String text, {
    double fontSize = 14,
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

  Widget statusBox({HeaderMenuType headerMenuType = HeaderMenuType.vertical}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderMenu(
            title: "Post",
            value: "999",
            headerMenuType: headerMenuType,
          ),
          HeaderMenu(
            title: "Follower",
            value: "999",
            headerMenuType: headerMenuType,
          ),
          HeaderMenu(
            title: "Folloing",
            value: "999",
            headerMenuType: headerMenuType,
          ),
        ],
      ),
    );
  }

  List<Widget> checkTarget(DragTargetItemModel model) {
    return [
      if (model.profile != null) ...[
        avatarBox(
          imageUrl: userData.imageUrl,
          borderRadius: model.profile!.borderRadius,
          size: model.profile!.size!,
        )
      ] else if (model.name != null) ...[
        if (model.name!.type == 1) ...[
          nameBox(),
        ] else if (model.name!.type == 2) ...[
          nameBox(crossAxisAlignment: CrossAxisAlignment.center),
        ] else if (model.name!.type == 3) ...[
          nameBox(crossAxisAlignment: CrossAxisAlignment.end),
        ]
      ] else if (model.status != null) ...[
        if (model.status!.type == 1) ...[
          statusBox(),
        ] else if (model.status!.type == 2) ...[
          statusBox(headerMenuType: HeaderMenuType.verticalRevease),
        ]
      ] else ...[
        defaultTarget()
      ]
    ];
  }

  Container defaultTarget() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
