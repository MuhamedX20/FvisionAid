import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  FlutterTts? _flutterTts;

  TextToSpeech() {
    _flutterTts = FlutterTts();
    _initializeTTS();
  }

  void _initializeTTS() async {
    await _flutterTts!.awaitSpeakCompletion(true);
    await _flutterTts!.setLanguage("en-US");
    await _flutterTts!.setSpeechRate(0.5); // Sets the speech rate to half the default speed
  }

  Future<void> setSpeechRate(double rate) async {
    await _flutterTts!.setSpeechRate(rate);
  }

  Future speak(String text) async {
    await _flutterTts!.speak(text);
  }

  Future stop() async {
    await _flutterTts!.stop();
  }
}
