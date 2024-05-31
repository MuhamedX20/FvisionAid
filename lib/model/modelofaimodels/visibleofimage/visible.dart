import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';


class Visible extends StatelessWidget {
  const Visible({ required this.picture, required this.on, this.status});
  final dynamic picture;
  final dynamic status;

  final void Function() on;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: status ,
        replacement: Image.file(
          File(
            picture ?? "",
          ),
          fit: BoxFit.cover,
          height: 80.h,
          width: 60.w,
        ),
        child: InkWell(
            onTap: () async {
              await Permission.storage.request();
              var status = await Permission.storage.status;
              if (status == PermissionStatus.granted) {
                on();
              } else {
                await Permission.storage.request();
              }
            },
            child: Column(
              children: [
                Image(image: const AssetImage("assets/im/upload.png"),
                  height: 60.h,
                  width: 60.w,
                ),
                SizedBox(height: 3.h,),
                const Text("Add Image")
              ],
            ),
            ),
        );
    }
}
