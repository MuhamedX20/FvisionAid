import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit_example/model_view/api_client.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/ocr_state.dart';
import 'package:image_picker/image_picker.dart';

class OcrCubit extends Cubit<OcrState> {
  final ApiClient apiClient;

  static OcrCubit get(context) => BlocProvider.of<OcrCubit>(context);

  File? picture;

  OcrCubit({required this.apiClient}) : super(OcrInitial());

  Future<void> addImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      picture = File(pickedFile.path);
      emit(OcrImageAdded(picture!));
    }
  }

  Future<void> sendImage() async {
    if (picture != null) {
      emit(OcrLoading());
      try {
        final ocrResult = await apiClient.performOcr(picture!);
        emit(OcrLoaded(ocrResult));
      } catch (e) {
        emit(OcrError(e.toString()));
      }
    }
  }
}
