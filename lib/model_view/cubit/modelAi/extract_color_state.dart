import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ExtractColorState extends Equatable {
  const ExtractColorState();

  @override
  List<Object?> get props => [];
}

class ExtractColorInitial extends ExtractColorState {}

class ExtractColorLoading extends ExtractColorState {}

class ExtractColorImageAdded extends ExtractColorState {
  final File image;

  const ExtractColorImageAdded(this.image);

  @override
  List<Object?> get props => [image];
}

class ExtractColorLoaded extends ExtractColorState {
  final List<String> colors;

  const ExtractColorLoaded(this.colors);

  @override
  List<Object?> get props => [colors];
}

class ExtractColorError extends ExtractColorState {
  final String message;

  const ExtractColorError(this.message);

  @override
  List<Object?> get props => [message];
}
