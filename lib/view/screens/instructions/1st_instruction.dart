import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit_example/model/move/move.dart';
import 'package:google_ml_kit_example/model_view/cubit/soundpool/cubit/sound_cubit.dart';

import 'location.dart';

class FirstInst extends StatefulWidget {

  @override
  State<FirstInst> createState() => _FirstInstState();
}

class _FirstInstState extends State<FirstInst> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
  }

  void speakText(String text) async {
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }
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
              decoration: const BoxDecoration(
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

                   SizedBox(height: 50.h,),
                   Text("   Welcome,\n to Vision Aid",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 100.h,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50.r),
                        gradient: LinearGradient(

                          transform: GradientRotation(double.parse("4")),
                          colors: const [
                            Color(0xFF766B6B),
                            Color(0xFFC04817),
                            Color(0xFF766B6B),

                          ],
                        ),
                        ///                 gradient: LinearGradient(transform: GradientRotation(double.parse("4")), colors: [Color(0xFFC04817),                   Color(0xFFC04817),],),
                      ),
                      width: 320.w,
                      child:  Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: InkWell(
                          onTap: (){
                            speakText("Welcome, to Vision Aid "
                                "\nSee the world in a new way with Vision Aid. "
                                "\nOur innovative app empowers blind and visually impaired individuals to navigate their surroundings, "
                                "access information, "
                                "and live more independently.");
                          },
                          child: Center(
                            child: Text(
                              "See the world in a new way with Vision Aid."
                                  "\nOur innovative app empowers blind and visually impaired individuals to navigate their surroundings,"
                                  "access information,"
                                  "and live more independently.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
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
                        Move.move(context,    Location());
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 10.w,),
                          Icon(Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                          SizedBox(width: 5.h,),
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
