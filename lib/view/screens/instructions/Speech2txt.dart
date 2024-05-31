import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit_example/model/utils/appimages.dart';
import 'package:google_ml_kit_example/view/screens/instructions/txt2speech.dart';

import '../../../model/move/move.dart';
import '../../../model_view/cubit/soundpool/cubit/sound_cubit.dart';



class Speech2txt extends StatefulWidget {

  @override
  State<Speech2txt> createState() => _Speech2txtState();
}

class _Speech2txtState extends State<Speech2txt> {
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
                        speakText("Back");
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


                  InkWell(
                    onTap: (){
                      speakText("This button Converts your spoken words into text you can hear and copy for easy sharing.");
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 50.h,),
                        SizedBox(height: 10.h,),
                        Text("Speech to text",
                          style:  TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50.h,),
                        Container(
                          height: 385.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50.r),
                            gradient: LinearGradient(
                              transform: GradientRotation(double.parse("4")),
                              colors:   [
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
                              child: Image(image: AssetImage(
                                AppImages.speechtotxtpic,
                              ),
                                width: 200.w,
                                height: 100.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),



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
                        speakText("Next");
                      },
                      onDoubleTap: (){
                        Move.move(context, Txt2speech());
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
// onTap: (){
// "Welcome to Color Detection";
// },
// text: "\"defin\"",
// label: "Colors detection",
// image: "assets/im/color-palette.png",
// voiceback: "assets/sound/audio.opus",
// voiceforwad: "assets/sound/audio.opus",
// voice: "assets/sound/audio.opus",
// nextscreen: Speech2txt(),
