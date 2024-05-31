import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit_example/model_view/api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


part 'model_ai_state.dart';

class ModelAiCubit extends Cubit<ModelAiState> {
  final ApiClient apiClient;
  File? picture;

  ModelAiCubit({required this.apiClient}) : super(ModelAiInitial());

  static ModelAiCubit get(context) => BlocProvider.of(context);

  Future<void> addImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      picture = File(pickedFile.path);
      emit(ModelAiImageAdded(picture!));
    }
  }

  Future<void> sendImage() async {
    if (picture != null) {
      emit(ModelAiLoading());
      try {
        final result = await apiClient.detectCash(picture!);
        final cash = result['Cash'] ?? 'Unknown'; // Ensure cash is non-null
        emit(ModelAiLoaded(cash));
      } catch (e) {
        emit(ModelAiError(e.toString()));
      }
    }
  }
}
