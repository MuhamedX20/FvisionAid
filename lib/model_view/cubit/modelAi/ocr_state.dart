import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class OcrState extends Equatable {
  const OcrState();

  @override
  List<Object?> get props => [];
}

class OcrInitial extends OcrState {}

class OcrLoading extends OcrState {}

class OcrImageAdded extends OcrState {
  final File image;

  const OcrImageAdded(this.image);

  @override
  List<Object?> get props => [image];
}

class OcrLoaded extends OcrState {
  final Map<String, dynamic> ocrResult;

  const OcrLoaded(this.ocrResult);

  @override
  List<Object?> get props => [ocrResult];
}

class OcrError extends OcrState {
  final String message;

  const OcrError(this.message);

  @override
  List<Object?> get props => [message];
}
