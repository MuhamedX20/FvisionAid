import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsScreen extends StatefulWidget {
  @override
  _TtsScreenState createState() => _TtsScreenState();
}

class _TtsScreenState extends State<TtsScreen> {
  late FlutterTts flutterTts;


  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speakFromClipboard();
  }

  Future<void> _speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(0.5);
      await flutterTts.setVolume(1.0);

      await flutterTts.speak(text);
    }
  }

  Future<void> _speakFromClipboard() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      _speak(clipboardData.text!);
    }
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
                    _speak("Back");
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
                      Text('Text To Speech',
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
              child: InkWell(
                onTap: _speakFromClipboard,
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
                      child: Center(
                        child: const Text('Speak Again'),
                      ),
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
