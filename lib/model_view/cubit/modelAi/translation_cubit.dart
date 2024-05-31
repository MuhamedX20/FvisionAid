import 'package:bloc/bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  TranslationCubit() : super(TranslationInitial());

  void translateText(String text) async {
    if (text.isNotEmpty) {
      emit(TranslationLoading());
      try {
        var translation = await _translator.translate(text, to: 'ar');
        emit(TranslationLoaded(translation.text));
        _speak(translation.text);
      } catch (e) {
        emit(TranslationError('Failed to translate text'));
      }
    }
  }

  void startListening() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      bool available = await _speechToText.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );
      if (available) {
        _speechToText.listen(onResult: (result) {
          if (result.finalResult) {
            translateText(result.recognizedWords);
          }
        });
      } else {
        emit(TranslationError('Speech recognition is not available'));
      }
    } else {
      emit(TranslationError('Microphone permission is not granted'));
    }
  }

  void _speak(String text) async {
    await _flutterTts.setLanguage("ar");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }
}
