import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/vision_detector_views/painters/model.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import 'detector_view.dart';
import 'painters/object_detector_painter.dart';
import 'utils.dart';

class ObjectDetectorView extends StatefulWidget {
  @override
  State<ObjectDetectorView> createState() => _ObjectDetectorView();
}

class _ObjectDetectorView extends State<ObjectDetectorView> {
  ObjectDetector? _objectDetector;
  DetectionMode _mode = DetectionMode.stream;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;
  TextToSpeech? tts;
  @override
  void initState() {
    super.initState();
    initializeTTS();
    _initializeDetector();
  }

  void initializeTTS() {
    tts = TextToSpeech();
  }



  @override
  void dispose() {
    _canProcess = false;
    _objectDetector?.close();
    tts?.stop(); // Ensure TTS is stopped when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DetectorView(
          title: 'Object Detector',
          customPaint: _customPaint,
          text: _text,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          onCameraFeedReady: _initializeDetector,
          initialDetectionMode: DetectorViewMode.values[_mode.index],
          onDetectorViewModeChanged: _onScreenModeChanged,
        ),
      ]),
    );
  }

  void _onScreenModeChanged(DetectorViewMode mode) {
    setState(() {
      _mode = (mode == DetectorViewMode.gallery)
          ? DetectionMode.single
          : DetectionMode.stream;
      _initializeDetector();
    });
  }

  void _initializeDetector() async {
    _objectDetector?.close();
    _objectDetector = null;
    final modelPath = await getAssetPath('assets/ml/object_labeler.tflite');

    final options = LocalObjectDetectorOptions(
      mode: _mode,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );

    _objectDetector = ObjectDetector(options: options);
    _canProcess = _objectDetector != null;
  }
List<String> _lastDetectedLabels = [];
List<String> _previousDetectedLabels = [];

Future<void> _processImage(InputImage inputImage) async {
  if (!_canProcess || _isBusy || _objectDetector == null) return;

  _isBusy = true;
  final objects = await _objectDetector!.processImage(inputImage);
  String resultText = 'Objects found: ${objects.length}. ';
  log("-----------------");
  log(resultText);
  log("-----------------");

  List<String> currentDetectedLabels = [];

  for (final object in objects) {
    String labels = object.labels.map((e) => e.text).join(', ');
    currentDetectedLabels.add(labels);
    resultText = ' ${labels} ';
    log("==================");
    log(resultText);
    log("==================");
  }

  if (_shouldAnnounce(currentDetectedLabels)) {
    setState(() {
      _text = resultText;
      _customPaint = CustomPaint(
          painter: ObjectDetectorPainter(
        objects,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      ));
    });

    tts!.speak(resultText);
  }

  _previousDetectedLabels = _lastDetectedLabels;
  _lastDetectedLabels = currentDetectedLabels;

  _isBusy = false;
}

bool _shouldAnnounce(List<String> currentDetectedLabels) {
  for (String label in currentDetectedLabels) {
    if (!_previousDetectedLabels.contains(label) || !_lastDetectedLabels.contains(label)) {
      return true;
    }
  }
  return false;
}
    /*الكود دا بيتعرف علي الحاجه كذا مره  */
  /*Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy || _objectDetector == null) return;

    _isBusy = true;
    final objects = await _objectDetector!.processImage(inputImage);
    String resultText = 'Objects found: ${objects.length}. ';
    log("-----------------");
    log(resultText);
    log("-----------------");

    for (final object in objects) {
      String labels = object.labels.map((e) => e.text).join(', ');
      resultText += 'Object: - Labels: ${labels}. ';
      log("==================");
      log(resultText);
      ("==================");
    }

    setState(() {
      _text = resultText;
      _customPaint = CustomPaint(
          painter: ObjectDetectorPainter(
        objects,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      ));
    });

    tts!.speak(resultText);
    _isBusy = false;
  }*/
}
