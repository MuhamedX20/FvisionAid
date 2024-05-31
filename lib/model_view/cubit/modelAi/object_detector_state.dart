import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/vision_detector_views/painters/object_detector_painter.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectDetectorState {
  final CustomPaint? customPaint;
  final String? text;
  final bool isBusy;

  ObjectDetectorState({this.customPaint, this.text, this.isBusy = false});
}

class ObjectDetectorCubit extends Cubit<ObjectDetectorState> {
  ObjectDetectorCubit() : super(ObjectDetectorState());

  ObjectDetector? _objectDetector;
  bool _canProcess = false;

  Future<void> initializeDetector(
      DetectionMode mode, String modelPath) async {
    _objectDetector?.close();
    _objectDetector = null;

    final options = LocalObjectDetectorOptions(
      mode: mode,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );

    _objectDetector = ObjectDetector(options: options);
    _canProcess = _objectDetector != null;
  }

  Future<void> processImage(
      InputImage inputImage, CameraLensDirection cameraLensDirection) async {
    if (!_canProcess || state.isBusy || _objectDetector == null) return;

    emit(ObjectDetectorState(isBusy: true));
    final objects = await _objectDetector!.processImage(inputImage);
    String resultText = 'Objects found: ${objects.length}. ';

    for (final object in objects) {
      String labels = object.labels.map((e) => e.text).join(', ');
      resultText += 'Object: - Labels: ${labels}. ';
    }

    emit(ObjectDetectorState(
      text: resultText,
      customPaint: CustomPaint(
        painter: ObjectDetectorPainter(
          objects,
          inputImage.metadata!.size,
          inputImage.metadata!.rotation,
          cameraLensDirection,
        ),
      ),
      isBusy: false,
    ));
  }

  void dispose() {
    _objectDetector?.close();
  }
}
