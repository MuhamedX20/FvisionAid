part of 'model_ai_cubit.dart';

abstract class ModelAiState {}

class ModelAiInitial extends ModelAiState {}

class ModelAiImageAdded extends ModelAiState {
  final File image;

  ModelAiImageAdded(this.image);
}

class ModelAiLoading extends ModelAiState {}

class ModelAiLoaded extends ModelAiState {
  final String cash;

  ModelAiLoaded(this.cash);
}

class ModelAiColorsLoaded extends ModelAiState {
  final List<String> colors;

  ModelAiColorsLoaded(this.colors);
}

class ModelAiError extends ModelAiState {
  final String message;

  ModelAiError(this.message);
}
