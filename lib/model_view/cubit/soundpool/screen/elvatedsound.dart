import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sound_cubit.dart';

class SoundElvated extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            BlocConsumer<SoundCubit,SoundState>(
                builder: (context, state) {
                  var soundcubit = SoundCubit.get(context);
                  return ElevatedButton(
                      onPressed: (){
                       soundcubit.play();
                      },
                      child: const Text("Click")
                  );
                },
                listener: (context, state) {

                },),
          ],
        ),
      );
  }
}
