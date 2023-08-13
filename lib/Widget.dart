// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled4/bloc/bloc.dart';
// import 'package:untitled4/bloc/blocB.dart';
// class widget extends StatelessWidget {
//   const widget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context){
//       var  statePlus=context.watch<ToDoBloc>();
//       var  stateMinus=context.watch<ToDoBlocB>();
//       return  Scaffold(
//           body: Center(
//             child: Row(
//               children: [
//                 TextButton(onPressed: (){
//                   statePlus.justDoSomeThinA();
//                 }, child: Text('plus')),
//                 SizedBox(width: 10,),
//                 Text('${statePlus.number}'),
//                 SizedBox(width: 10,),
//                 TextButton(onPressed: (){
//                   stateMinus.justDoSomeThin();
//                 }, child: Text('minus')),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  String start=input[0];
  String end=input[input.length-1];
  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);

  }
  for (int i = 0; i < input.length; i++) {
    input[i]!=start;
    input[i]!=input[input.length-1];
    start=end;
    input[i]!=start;

  }

  return input;
}