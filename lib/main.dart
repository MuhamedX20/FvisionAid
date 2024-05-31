/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision/model_view/cubit/modelAi/model_ai_cubit.dart';
import 'package:vision/model_view/cubit/soundpool/cubit/sound_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vision/model_view/cubit/ttscubit/tcubit/t_ts_cubit.dart';
import 'package:vision/view/screens/main/mainscreen.dart';


void main() {
  runApp(
      MultiBlocProvider(
        providers:
          [
            BlocProvider(create: (context) => SoundCubit(),),
            BlocProvider(create: (context) => ModelAiCubit(apiClient: null),),
            BlocProvider(create: (context) => TTSCubit(),),
          ],
        child:   const ScreenUtilInit(
          designSize: Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          child : MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        ),
        ),
      ),
  );
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit_example/model_view/api_client.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/extract_color_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/model_ai_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/object_detector_state.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/orc_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/translation_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/soundpool/cubit/sound_cubit.dart';
import 'package:google_ml_kit_example/model_view/cubit/ttscubit/tcubit/t_ts_cubit.dart';
import 'package:google_ml_kit_example/view/aimodels/translate_screen.dart';
import 'package:google_ml_kit_example/view/screens/instructions/1st_instruction.dart';
import 'package:google_ml_kit_example/view/screens/main/mainscreen.dart';
import 'package:google_ml_kit_example/view/screens/onboarding/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(
        create: (_) => TranslationCubit(),
        child: TranslationScreen(),
      ),
       BlocProvider<ObjectDetectorCubit>(
          create: (context) => ObjectDetectorCubit(),
        ),
        BlocProvider<ModelAiCubit>(
          create: (context) => ModelAiCubit(apiClient: apiClient),
        ),
        BlocProvider(
          create: (context) => ExtractColorCubit(apiClient: apiClient),
        ),
        BlocProvider(
          create: (context) => OcrCubit(apiClient: apiClient),
        ),
        BlocProvider(
          create: (context) => TTSCubit(),
        ),
        BlocProvider(
          create: (context) => SoundCubit(),
        ),
      ],
      child:  ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirstInst(),
        ),
      ),
    );
  }
}
