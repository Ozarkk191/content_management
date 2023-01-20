import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/user_bloc.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/constant.dart';
import '../../../widgets/header_type/header_profile.dart';
import '../../../widgets/layouts/main_layout.dart';

class HeaderType extends StatefulWidget {
  final int type;
  const HeaderType({super.key, this.type = 0});

  @override
  State<HeaderType> createState() => _HeaderTypeState();
}

class _HeaderTypeState extends State<HeaderType> {
  int selectType = 0;
  List<int> typeList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  void initState() {
    selectType = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
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
                child: HeaderProfile(
                  totalContent: 999,
                  headerType: selectType,
                  user: user,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "รูปแบบโปรไฟล์",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
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
    });
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
          Navigator.pop(context);
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
            Navigator.pop(context, selectType);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                "บันทึก",
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
