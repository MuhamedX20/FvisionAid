import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit_example/model_view/cubit/soundpool/cubit/sound_cubit.dart';

import '../move/move.dart';

class ModelInst extends StatefulWidget {
  const ModelInst({ required this.text, required this.label, required this.image, required this.voice, required this.nextscreen, required this.voiceback, required this.voiceforwad, required this.onTap});
final String text;
final String label;
final String image;
final String voice;
final String voiceback;
final String voiceforwad;
final Widget nextscreen;
final void Function() onTap;
  @override
  State<ModelInst> createState() => _ModelInstState();
}

class _ModelInstState extends State<ModelInst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SoundCubit,SoundState>(
          builder: (context, state) {
            var soundcubit = SoundCubit.get(context);

            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Color(0xFF898787),
                  ],
                ),
              ),
              child: Column(
                children: [
                   SizedBox(height: 5.h,),
                  Container(
                    height: 50.h,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25.r),
                            bottomLeft: Radius.circular(25.r)
                        ),
                        color: const Color(0xFFC04817),
                        shape: BoxShape.rectangle
                    ),
                    child: InkWell(
                      onTap: (){
                        soundcubit.play(sound:"assets/sound/audio.opus",);
                      },
                      onDoubleTap: (){
                        Navigator.pop(context);
                      },
                      child:  Row(
                        children: [
                          SizedBox(width: 10.w,),
                          Icon(Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(height: 50.h,),
                  Image(image: AssetImage(
                    widget.image,
                  ),),
                   SizedBox(height: 10.h,),
                  Text(widget.label,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 50.h,),
                  Expanded(
                    child: InkWell(
                      onTap: widget.onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50.r),
                          gradient: LinearGradient(

                            transform: GradientRotation(double.parse("4")),
                            colors:   const [
                              Color(0xFF766B6B),
                              Color(0xddC04817),
                              Color(0xFF766B6B),

                            ],
                          ),
                          ///                 gradient: LinearGradient(transform: GradientRotation(double.parse("4")), colors: [Color(0xFFC04817),                   Color(0xFFC04817),],),
                        ),
                        width: 320.w,
                        child: Padding(
                          padding:  EdgeInsets.all(12.sp),
                          child: Center(
                            child: Text(
                              widget.text,
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 20.h,),
                  Container(
                    height: 50.h,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.r),
                            topLeft: Radius.circular(25.r)
                        ),
                        color: const Color(0xFFC04817),
                        shape: BoxShape.rectangle
                    ),
                    child: InkWell(
                      onTap: (){
                        soundcubit.play(sound:"assets/sound/audio.opus",);
                      },
                      onDoubleTap: (){
                        Move.move(context,widget.nextscreen);
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 10.w,),
                          Icon(Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                          SizedBox(width: 5.w,),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
