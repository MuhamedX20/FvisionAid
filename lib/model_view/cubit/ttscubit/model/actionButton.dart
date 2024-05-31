import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit_example/model/customButton/customButton.dart';
import 'package:google_ml_kit_example/model_view/cubit/ttscubit/tcubit/t_ts_cubit.dart';

class ActionButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: "Add Text",
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlocConsumer<TTSCubit, TTSState>(
                  listener: (context, state) {
                    var cubit = TTSCubit.get(context);
                    if (state is TTSSuccessState) {
                      cubit.TTSController.clear();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    var cubit = TTSCubit.get(context);
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10.h,),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                hintText: 'Enter Text',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: 'Text',
                                labelStyle: TextStyle(
                                    color: Colors.black
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                ),
                              ),
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: cubit.validatorOfName,
                              textAlign: TextAlign.start,
                              controller: cubit.TTSController,
                            ),

                          ],
                        ),
                      ),
                      actions: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onTap: () {
                              cubit.addtextofTTS();
                            },
                            text: 'Add',
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancel',

                          ),
                        ),
                      ],
                    );
                  },
                );
              }
          );
        }
    );
  }
}
