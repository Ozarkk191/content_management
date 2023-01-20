import 'package:ccm/models/user_model.dart';
import 'package:ccm/src/pages/home/other_profile_page.dart';
import 'package:ccm/src/widgets/header_type/header_profile.dart';
import 'package:ccm/src/widgets/layouts/main_layout.dart';
import 'package:ccm/src/widgets/textfields/main_textfield.dart';
import 'package:ccm/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserModel> userList = [];
  List<UserModel> userdummyList = [];
  bool loading = true;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController search = TextEditingController();

  void getAllUser() async {
    firestore.collection("User").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        UserModel userData = UserModel.fromJson(value.docs[i].data());
        userdummyList.add(userData);
      }
      userList = userdummyList;
      setState(() => loading = false);
    });
  }

  void onSearch(String keyword) {
    List<UserModel> results = [];
    if (keyword.isEmpty) {
      results = userdummyList;
    } else {
      results = userdummyList
          .where((user) =>
              user.fullName!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      userList = results;
    });
  }

  @override
  void initState() {
    getAllUser();
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      loading: loading,
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "รายชื่อผู้ใช้งาน",
                  style: TextStyle(
                    color: fontColor.withOpacity(0.9),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MainTextField(
              controller: search,
              hintText: "ค้นหาผู้ใช้งาน",
              prefix: const Icon(Icons.search),
              onChanged: (value) => onSearch(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtherProfilePage(uid: userList[index].uid!),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 10,
                          color: Colors.grey.shade300,
                          offset: const Offset(1, 3),
                        ),
                      ],
                    ),
                    child: HeaderProfile(
                      totalContent: 10,
                      user: userList[index],
                      headerType: 6,
                      isOther: true,
                      createPost: () {},
                      editProfile: () {},
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
