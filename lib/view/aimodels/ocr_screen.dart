import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model_view/cubit/modelAi/orc_cubit.dart';
import '../../model_view/cubit/modelAi/ocr_state.dart';

class OcrScreen extends StatefulWidget {
  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  late FlutterTts flutterTts;
  bool isTtsInitialized = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initTts();
    openCamera();
  }

  Future<void> initTts() async {
    flutterTts.setStartHandler(() {
      setState(() {
        isTtsInitialized = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        isTtsInitialized = false;
      });
    });

    flutterTts.setErrorHandler((msg) {
      print("TTS Error: $msg");
      setState(() {
        isTtsInitialized = false;
      });
    });

    await configureTts();
  }

  Future<void> configureTts() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    setState(() {
      isTtsInitialized = true;
    });
  }

  Future<void> speakText(String text) async {
    if (isTtsInitialized) {
      var result = await flutterTts.speak(text);
      print("Speak result: $result");
    } else {
      print("TTS engine is not initialized");
    }
  }

  Future<void> openCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        var cubit = OcrCubit.get(context);
        cubit.picture = File(pickedFile.path);
        cubit.sendImage();

        // For OCR
        var ocrCubit = OcrCubit.get(context);
        ocrCubit.picture = File(pickedFile.path);
        ocrCubit.sendImage();
      }
    } else {
      print("Camera permission denied");
      speakText("Camera permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<OcrCubit, OcrState>(
              builder: (context, state) {
                var cubit = OcrCubit.get(context);
                if (state is OcrLoaded) {
                  final ocrText = state.ocrResult['Cash']['result'];
                  speakText('OCR Result: $ocrText');
                  return Column(
                    children: [
                      SizedBox(height: 100.h,),
                      Center(
                        child: Column(
                          children: [
                            if (cubit.picture != null)
                              Image.file(cubit.picture!, height: 200.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Text('OCR Result: $ocrText', style: const TextStyle(fontSize: 24, color: Colors.white)),
                    ],
                  );
                }
                return Column(
                  children: [
                    SizedBox(height: 100.h,),
                    Center(
                      child: Column(
                        children: [
                          if (cubit.picture != null)
                            Image.file(cubit.picture!, height: 200.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    if (state is OcrLoading)
                      const CircularProgressIndicator(),
                    if (state is OcrError)
                      Text('Error: ${state.message}', style: const TextStyle(fontSize: 24, color: Colors.red)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
