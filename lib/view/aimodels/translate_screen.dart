import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit_example/model/move/move.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/translation_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/translation_state.dart';


class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  @override
  FlutterTts flutterTts = FlutterTts();
  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
  }

  void speakText(String text) async {
    await flutterTts.speak(text);
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TranslationCubit>().startListening();
    });
    configureTts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 12.0,
                left: 12,
              ),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    color: Color(0xFFC04817),
                    shape: BoxShape.rectangle),
                child: InkWell(
                  onTap: () {
                    speakText("Back");
                  },
                  onDoubleTap: () {
                    Navigator.pop(context);
                  },
                  child:  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 60.w,),
                      Text('Translate to Arabic',
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 15.sp
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Expanded(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text(
                        'Listening...',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<TranslationCubit, TranslationState>(
                        builder: (context, state) {
                          if (state is TranslationLoading) {
                            return Container(
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
                                child: Center(child: CircularProgressIndicator()));
                          } else if (state is TranslationLoaded) {
                            return Container(
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
                              child: Center(
                                child: Text(
                                  state.translatedText,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          } else if (state is TranslationError) {
                            return Text(
                              state.message,
                              style: const TextStyle(fontSize: 20, color: Colors.red),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
