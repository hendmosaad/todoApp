import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled4/archivedtasks.dart';
import 'package:untitled4/bloc/BlocBstates.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/donetasks.dart';
import 'package:untitled4/newTask.dart';

class ToDoBlocB extends Cubit<ToDoB>{
  ToDoBlocB():super(initialStateB());
  static ToDoBlocB get(context) => BlocProvider.of(context);
  justDoSomeThin(){
    print('justDoSomeThing');
    emit(justDoSomeThing());
  }

}