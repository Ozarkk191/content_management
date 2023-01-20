import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../widgets/layouts/main_layout.dart';

class EditSubPage extends StatefulWidget {
  final String title;
  final String value;
  const EditSubPage({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<EditSubPage> createState() => _EditSubPageState();
}

class _EditSubPageState extends State<EditSubPage> {
  TextEditingController value = TextEditingController();

  @override
  void initState() {
    value.text = widget.value;
    super.initState();
  }

  @override
  void dispose() {
    value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: appbar(context),
      child: Column(
        children: [
          line(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title),
                TextField(
                  controller: value,
                  autofocus: true,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "เพิ่ม${widget.title}",
                    suffixIcon: InkWell(
                      onTap: () {
                        value.clear();
                        setState(() {});
                      },
                      child: const Icon(Icons.close_rounded),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          line(),
        ],
      ),
    );
  }

  Container line() {
    return Container(
      height: 1,
      color: Colors.grey.shade300,
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: fontColor,
          fontSize: 18,
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
          onTap: value.text == widget.value || value.text == ""
              ? null
              : () {
                  Navigator.pop(context, value.text);
                },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                "บันทึก",
                style: TextStyle(
                  color: value.text == widget.value || value.text == ""
                      ? Colors.grey
                      : primaryColor,
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
