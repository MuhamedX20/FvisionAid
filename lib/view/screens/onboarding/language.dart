import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/view/screens/main/mainscreen.dart';


import '../../../model/move/move.dart';

class LangChoose extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF898787),
                Colors.black,
              ],
          ),
        ),
        child: InkWell(
          onTap: (){
            Move.move(context,   MainScreen());
          },
          child: Column(
            children: [
              const SizedBox(height: 120,),
              const Center(child: Image(image: AssetImage("assets/im/Logo.png",),)),
              const SizedBox(height: 120,),
              const Text("Choose Language",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Column(
                     children: [
                       ElevatedButton(onPressed: (){},
                         style: ElevatedButton.styleFrom(
                           backgroundColor:  const Color(0xFF898787),
                           fixedSize: const Size(175, 250),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                         ),
                         child:  const Text("English",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 30,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(width: 10,),
                   Column(
                     children: [

                       ElevatedButton(onPressed: (){},
                         style: ElevatedButton.styleFrom(
                           backgroundColor:  const Color(0xFF898787),
                           fixedSize: const Size(175, 250),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                         ),
                         child:  const Text("العربية",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 30,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
