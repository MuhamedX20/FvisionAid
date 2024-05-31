import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit_example/model_view/cubit/ttscubit/tcubit/t_ts_cubit.dart';

import '../../model_view/cubit/ttscubit/model/actionButton.dart';


class TTS extends StatefulWidget {

  @override
  State<TTS> createState() => _TTSState();
}

class _TTSState extends State<TTS> {
  late  String texttospeech;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TTS'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1000.h,
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
          child: Column(
            children: [
              BlocConsumer<TTSCubit,TTSState>(
                builder: (context, state) {
                  var cubit = TTSCubit.get(context);
                  return ListView.separated(
                    padding:const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          side:const  BorderSide(color: Colors.black),
                        ),
                        height: 60,
                        onPressed: () {
                          speakText(
                              cubit.TTSlist[index].textOfTTS
                          );
                        },
                        child: Text(
                          cubit.TTSlist[index].textOfTTS,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    separatorBuilder:  (context, index) => SizedBox(height: 10.h,),
                    itemCount: cubit.TTSlist.length,
                  );
                },
                listener: (context, state) {

                },
              ),
              Positioned(
                  bottom: 30.h,

                  child:  ActionButton()),
              SizedBox(height: 15.h,),

            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// FlutterTts flutterTts = FlutterTts();
//
// Future<void> configureTts() async {
//   await flutterTts.setLanguage('en-US');
//   await flutterTts.setSpeechRate(1.0);
//   await flutterTts.setVolume(1.0);
// }
//
// void speakText(String text) async {
//   await flutterTts.speak(text);
// }
//
// void stopSpeaking() async {
//   await flutterTts.stop();
// }
//
// class Llol extends StatelessWidget {
//   const Llol({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//             child: IconButton(
//                 onPressed: () {
//                   speakText('hello');
//                 },
//                 icon: const Icon(Icons.play_arrow),
//                 iconSize: 100)),
//       ),
//     );
//   }
// }





