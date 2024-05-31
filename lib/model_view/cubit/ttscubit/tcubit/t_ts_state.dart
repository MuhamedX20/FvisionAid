part of 't_ts_cubit.dart';

@immutable
sealed class TTSState {}

final class TTsInitial extends TTSState {}

final class TTSSuccessState extends TTSState {}
