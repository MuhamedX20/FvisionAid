import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/ttsmodel.dart';

part 't_ts_state.dart';

class TTSCubit extends Cubit<TTSState> {
  TTSCubit() : super(TTsInitial());
  
  static TTSCubit get(context) => BlocProvider.of<TTSCubit>(context);
  
  var TTSController = TextEditingController();
  List<TTSModel>TTSlist =[];
  
  void addtextofTTS(){
    TTSlist.add(TTSModel(textOfTTS: TTSController.text));
    emit(TTSSuccessState());
  }

  String? validatorOfName(String? value){
    {
      if ((value)!.isEmpty){
        return 'please , Enter Phone Name';
      }
      return null;
    }
  }
  
}
