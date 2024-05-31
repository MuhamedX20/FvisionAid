import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatelessWidget {
   CustomButton({required this.onTap, required this.text});
  final void Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          fixedSize: Size(320.w, 60.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
        ),
        onPressed: onTap ,
        child: Text(
           text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
          ),
        )
    );
  }
}