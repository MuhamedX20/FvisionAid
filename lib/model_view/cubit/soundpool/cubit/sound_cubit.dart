

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundpool/soundpool.dart';

part 'sound_state.dart';

class SoundCubit extends Cubit<SoundState> {
  SoundCubit() : super(SoundInitial());

  static SoundCubit get(context) => BlocProvider.of(context);

  Soundpool pool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);



  static const String moSound = "assets/sound/salyallamohamed.ogg";




  play({String? sound}) async {
    int soundId = await rootBundle.load(sound ?? moSound).then((ByteData soundData){
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
    emit(PlaySoundState());
  }
}
