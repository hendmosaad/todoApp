import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/states.dart';
class Archivedtasks extends StatelessWidget {
  const Archivedtasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ToDoBloc,ToDoStates>(
    listener: (context,states){},
    builder: (context,states){
      return Scaffold(
        backgroundColor: Colors.white54,
        body: Center(
            child: Text('Archivedtasks'),
        ),
      );
    },
  );
  }
}
