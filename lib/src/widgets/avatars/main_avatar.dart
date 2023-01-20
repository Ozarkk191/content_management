import 'dart:io';

import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class MainAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? radius;
  final double border;
  final File? file;
  final Function()? onTap;
  const MainAvatar({
    super.key,
    this.imageUrl,
    this.radius,
    this.border = 3,
    this.onTap,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: radius != null ? (radius! * 2) : null,
        height: radius != null ? (radius! * 2) : null,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(border),
              decoration: const BoxDecoration(
                color: fontColor,
                shape: BoxShape.circle,
              ),
              child: file != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(file!),
                      radius: radius,
                    )
                  : imageUrl != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl!),
                          radius: radius,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              const AssetImage("assets/icons/icon_app.png"),
                          radius: radius,
                        ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Visibility(
                visible: onTap != null,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: fontColor.withOpacity(0.8),
                  ),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
