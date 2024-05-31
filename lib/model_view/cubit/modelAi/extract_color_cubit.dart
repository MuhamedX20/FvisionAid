import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit_example/model_view/api_client.dart';
import 'package:google_ml_kit_example/model_view/cubit/modelAi/extract_color_state.dart';
import 'package:image_picker/image_picker.dart';

class ExtractColorCubit extends Cubit<ExtractColorState> {
  final ApiClient apiClient;
  File? picture;

  static ExtractColorCubit get(context) => BlocProvider.of<ExtractColorCubit>(context);


  ExtractColorCubit({required this.apiClient}) : super(ExtractColorInitial());

  Future<void> addImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      picture = File(pickedFile.path);
      emit(ExtractColorImageAdded(picture!));
    }
  }

  Future<void> sendImage() async {
    if (picture != null) {
      emit(ExtractColorLoading());
      try {
        final colors = await apiClient.extractColors(picture!);
        emit(ExtractColorLoaded(colors));
      } catch (e) {
        emit(ExtractColorError(e.toString()));
      }
    }
  }
}
