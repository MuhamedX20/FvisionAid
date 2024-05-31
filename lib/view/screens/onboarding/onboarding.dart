import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit_example/view/screens/instructions/1st_instruction.dart';


import '../../../model/move/move.dart';

class OnBoarding extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF000000),
      body: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF898787),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: InkWell(
            onTap: (){
              Move.move(context,  FirstInst());
            },
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 220.h,),
                 const Center(child: Image(image: AssetImage("assets/im/Logo.png",),)),
                  SizedBox(height: 200.h,),
                Text("Vision Aid",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
