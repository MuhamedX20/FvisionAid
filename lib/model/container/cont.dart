// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
final Widget icon;
final void Function() onTap;
final void Function() onDoubleTap;
final String defination;
  const CustomButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.onDoubleTap,
    required this.defination,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onDoubleTap: onDoubleTap,
      onTap: onTap,
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(18.r),
          gradient: LinearGradient(

            transform: GradientRotation(double.parse("4")),
              colors:  const [
                Color(0xFF000000),
                Color(0xFF766B6B),

              ],
          ),
        ),
        child: BlurryContainer(
          blur: 10,

          elevation: 0,
          color: Colors.transparent,

          borderRadius:  BorderRadius.all(Radius.circular(20.r)),
          child: Column(
            children: [
              Row(
                children: [
                   Expanded(child: SizedBox(width: 2.w,)),
                  icon,
                   SizedBox(width: 5.w,),
                ],
              ),
               SizedBox(height: 24.h),
              Row(

                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   SizedBox(width: 12.w,),
                  Text(
                    defination,
                    style:  TextStyle(
                      height: 1.h,
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
