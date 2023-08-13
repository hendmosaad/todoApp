import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/constants.dart';
import 'package:untitled4/sharedprefrences.dart';
import 'package:untitled4/startWidget.dart';
class LayOut extends StatelessWidget {

   LayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoBloc,ToDoStates>(

      listener: (context,stats){
      },
      builder: (context,stats){
        var cubit=ToDoBloc.get(context);
       print(index);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple[900],
            elevation: 0.0,
            title: Text(cubit.titles[cubit.cusrrentIndex]),
            // actions: [
            //   TextButton(onPressed: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>StartWidget()));
            //   }, child: Text('change name'))
            // ],
          ),
          body:cubit.screens[cubit.cusrrentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeIndex(index);
            },
            currentIndex: cubit.cusrrentIndex,
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.grey,),label: 'home',),
              BottomNavigationBarItem(icon: Icon(Icons.done,color: Colors.grey),label: 'done'),
              BottomNavigationBarItem(icon: Icon(Icons.archive_outlined,color: Colors.grey),label: 'archived'),
            ],
          ),
        );
      },
    );
  }
}
