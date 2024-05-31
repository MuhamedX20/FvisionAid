import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit_example/model/container/cont.dart';
import 'package:google_ml_kit_example/model/move/move.dart';
import 'package:google_ml_kit_example/model_view/api_client.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/model_ai_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/tts_screen.dart';
import 'package:google_ml_kit_example/model_view/cubit/soundpool/cubit/sound_cubit.dart';
import 'package:google_ml_kit_example/view/aimodels/extract_colors_screen.dart';
import 'package:google_ml_kit_example/view/aimodels/locationmodel.dart';
import 'package:google_ml_kit_example/view/aimodels/moneymodel.dart';
import 'package:google_ml_kit_example/view/aimodels/ocr_screen.dart';
import 'package:google_ml_kit_example/view/aimodels/qiblamodel.dart';
import 'package:google_ml_kit_example/view/aimodels/translate_screen.dart';
import 'package:google_ml_kit_example/view/screens/instructions/1st_instruction.dart';
import 'package:google_ml_kit_example/vision_detector_views/object_detector_view.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FlutterTts flutterTts = FlutterTts();
  final ApiClient apiClient = ApiClient(); // Add this line
  late ModelAiCubit modelAiCubit; // Update this line

  late List<Widget> screens; // Declare screens list

  @override
  void initState() {
    super.initState();
    modelAiCubit =
        ModelAiCubit(apiClient: apiClient); // Initialize the ModelAiCubit
    configureTts();
    initializeScreens(); // Initialize screens list
  }

  void initializeScreens() {
    screens = [
      LocationModel(),
      TtsScreen(), 
      Qibla(),
      MoneyModelScreen(),
      TranslationScreen(),
      ObjectDetectorView(),
      OcrScreen(),
      ExtractColorsScreen(),
    ];
  }

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

  List<String> soundspeak = [
    "Location",
    "Text to speech",
    "Qibla",
    "Money detection",
    "Translation",
    "Object detection",
    "Extrate text from image",
    "Colors detection",
  ];

  final List<String> sound = [
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
    "assets/sound/audio.opus",
  ];

  final List defination = [
    "Location",
    "Text to \nspeech",
    "Qibla",
    "Money \ndetection",
    "Translation",
    "Object \ndetection",
    "Extrate text \nfrom image",
    "Colors \ndetection",
  ];

  final List<Widget> icons = [
    Icon(
      Icons.location_on,
      size: 60.sp,
      color: Colors.white,
    ),
    Image(
      image: const AssetImage(
        "assets/im/text-to-speech.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
    Image(
      image: const AssetImage(
        "assets/im/qibla.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
    Image(
      image: const AssetImage(
        "assets/im/money detection.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
    Image(
      image: const AssetImage(
        "assets/im/translate.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
    Image(
      image: const AssetImage(
        "assets/im/object recognition.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
    Image(
      image: const AssetImage(
        "assets/im/ExtractTxt4mimg.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
    Image(
      image: const AssetImage(
        "assets/im/color-palette.png",
      ),
      height: 50.h,
      width: 60.w,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: SingleChildScrollView(
        child: BlocBuilder<SoundCubit, SoundState>(
          builder: (context, state) {
            //var soundcubit = SoundCubit.get(context);
            return SafeArea(
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
                          Move.move(context, FirstInst());
                        },
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 15.5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: List.generate(
                      defination.length,
                      (index) => CustomButton(
                        onTap: () {
                          speakText(soundspeak[index]);
                        },
                        onDoubleTap: () {
                          Move.move(context, screens[index]);
                        },
                        icon: icons[index],
                        defination: defination[index],
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
