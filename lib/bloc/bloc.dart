import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:translator/translator.dart';
import 'package:untitled4/archivedtasks.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/constants.dart';
import 'package:untitled4/donetasks.dart';
import 'package:untitled4/generated/l10n.dart';
import 'package:untitled4/newTask.dart';

typedef getMeth({required String date, required Database database});

class ToDoBloc extends Cubit<ToDoStates> {
  ToDoBloc() : super(initialState());

  static ToDoBloc get(context) {
    return BlocProvider.of(context);
  }

  int number = 0;
  bool isOpen = false;
  String lang='en';
  int cusrrentIndex = 0;
  int currentCategoryIndex = 0;
  String ? name;
  DateTime choosedDate = DateTime.now();

  void cahngeLang(String language){
    lang=language;
    emit(cahngrLangSuccess());
  }
  void changeName(String name){
   this. name=name;
    emit(changeNameSuccess());
  }
  onOffButtomSheet() {
    isOpen = !isOpen;
    emit(onOffButtomSheet());
  }
  changeIndex(int x) {
    cusrrentIndex = x;
    emit(changeIndexSuccess());
  }
  changeCategoryIndex(int x) {
    currentCategoryIndex = x;
    emit(changeCategryIndexSuccess());
  }

  List<Widget> screens = [NewTasks(), DoneTasks(),Archivedtasks() ];
  List<String> titles = ['New tasks', 'Done tasks', 'Arcived tasks'];
  List<String> images = [
    'assets/work.png',
    'assets/gym.png',
    'assets/religious.png',
    'assets/hoppies.png',
    'assets/notes.png',
    'assets/family.png'
  ];

  List getAddresses(context)=>[
  '${S.of(context).wortTitle}',
  '${S.of(context).healthTitle}',
  '${S.of(context).religiousTitle}',
  '${S.of(context).hopiesTitle}',
  '${S.of(context).notesTitle}',
  '${S.of(context).familyTitle}'
  ];


  changeChoosedDate({required comingDate}) {
    choosedDate = comingDate;
    emit(ChoosedDate());
  }

  List<Map> newTasks = [];
  List<Map> archivedTasks = [];
  List<Map> doneTasks = [];
  List<bool> checks = [];
  Database? healthDatabase;
  Database? workDatabase;
  Database? religiousDatabase;
  Database? familyDatabase;
  Database? hopiesDatabase;
  Database? notesDatabase;

  void healthDataBase() async {
    healthDatabase = await openDatabase('health.db', version: 1,
        onCreate: (gymDatabase, version) async {
      gymDatabase
          .execute(
              'CREATE TABLE health (id INTEGER PRIMARY KEY, text TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        emit(HealthDataBaseCreatedSuccess());
      }).catchError((onError) {
        emit(HealthDataBaseCreatedError());
      });
    }, onOpen: (database) {
      emit(HealthDataBaseOpenSucces());
      getIntoHealth(date: '${DateTime.now().day}', database: database);
      print('HealthDatabase');
    });
  }

  void workDataBase() async {
    workDatabase = await openDatabase('work.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE work (id INTEGER PRIMARY KEY, text TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        emit(WorkDataBaseCreatedSuccess());
      }).catchError((onError) {
        emit(WorkDataBaseCreatedError());
      });
    }, onOpen: (database) {
      // getIntoWork(date: DateFormat.yMMMd().format(DateTime.now()), database: database);
      print('workdatabaseopened');
    });
  }

  void religiousDataBase() async {
    religiousDatabase = await openDatabase('religious.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE religious (id INTEGER PRIMARY KEY, text TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        emit(ReligiousDataBaseCreatedSuccess());
      }).catchError((onError) {
        emit(ReligiousDataBaseCreatedError());
      });
    }, onOpen: (database) {
      print('religiousdatabaseopened');
    });
  }

  void familyDataBase() async {
    familyDatabase = await openDatabase('family.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE family (id INTEGER PRIMARY KEY, text TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        emit(FamilyDataBaseCreatedSuccess());
      }).catchError((onError) {
        emit(FamilyDataBaseCreatedError());
      });
    }, onOpen: (database) {
      print('familydatabaseopened');
    });
  }

  void hoppiesDataBase() async {
    hopiesDatabase = await openDatabase('hoppies.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE hoppies (id INTEGER PRIMARY KEY, text TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        emit(HopiesDataBaseCreatedSuccess());
      }).catchError((onError) {
        emit(HopiesDataBaseCreatedError());
      });
    }, onOpen: (database) {
      print('hoppiesdatabaseopened');
    });
  }

  void notesDataBase() async {
    notesDatabase = await openDatabase('notes.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE notes(id INTEGER PRIMARY KEY, text TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        emit(NotesDataBaseCreatedSuccess());
      }).catchError((onError) {
        emit(NotesDataBaseCreatedError());
      });
    }, onOpen: (database) {
      print('notesdatabaseopened');
    });
  }

  Future<void> insertIntoHealth(
      {
      required Database healthDataBase,
      required String title,
      required String date,
      required String time,
      required String getDate}) async {
    healthDatabase!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO health( text,date,time, status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        emit(HealthInsertionSuccess());
        print(value);
        getIntoHealth(database: healthDataBase, date: getDate);
      }).catchError((onError) {
        print("insertion error${onError}");
        emit(HealthInsertionError());
      });
      return Future(() {});
    }).then((value) {
      emit(HealthInsertionSuccess());
      getIntoHealth(database: healthDataBase, date: '${DateTime.now().day}');
    }).catchError((onError) {
      emit(HealthInsertionError());
    });
  }

  Future<void> insertIntoWork(
      {required Database workDataBase,
      required String title,
      required String date,
      required String time,
      required String getDate}) async {
    workDatabase!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO work (text,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        getIntoWork(database: workDataBase, date: getDate);
        emit(WorkInsertionSuccess());
      }).catchError((onError) {
        emit(WorkInsertionError());
      });
      return Future(() {});
    }).then((value) {
      print('work transcation $value');
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> insertIntoReligious(
      {required Database religiousDataBase,
      required String title,
      required String date,
      required String time,
      required String getDate}) async {
    religiousDatabase!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO religious( text,date,time, status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        emit(ReligiousInsertionSuccess());
      }).catchError((onError) {
        print("insertion error${onError}");
        emit(ReligiousInsertionError());
      });
      return Future(() {});
    }).then((value) {
      emit(ReligiousInsertionSuccess());
      getIntoReligious(database: religiousDataBase, date: getDate);
    }).catchError((onError) {
      emit(ReligiousInsertionError());
    });
  }

  Future<void> insertIntoFamily(
      {required Database familyDataBase,
      required String title,
      required String date,
      required String time,
      required String getDate}) async {
    familyDatabase!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO family( text,date,time, status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        emit(FamilyInsertionSuccess());
      }).catchError((onError) {
        print("insertion error${onError}");
        emit(FamilyInsertionError());
      });
      return Future(() {});
    }).then((value) {
      emit(FamilyInsertionSuccess());
      getIntoFamily(database: familyDataBase, date: getDate);
    }).catchError((onError) {
      emit(FamilyInsertionError());
    });
  }

  Future<void> insertIntoHopies(
      {required Database hopiesDataBase,
      required String title,
      required String date,
      required String time,
      required String getDate}) async {
    hopiesDatabase!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO hoppies( text,date,time, status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        getIntoHopies(database: hopiesDataBase, date: getDate);
        emit(HoppiesInsertionSuccess());
      }).catchError((onError) {
        print("insertion error${onError}");
        emit(HoppiesInsertionError());
      });
      return Future(() {});
    }).then((value) {
      emit(HoppiesInsertionSuccess());
    }).catchError((onError) {
      emit(HoppiesInsertionError());
    });
  }

  Future<void> insertIntoNotes(
      {required Database notesDataBase,
      required String title,
      required String date,
      required String time,
      required String getDate}) async {
    notesDatabase!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO notes ( text,date,time, status) VALUES("$titles", "$date", "$time","new")')
          .then((value) {
        emit(NotesInsertionSuccess());
      }).catchError((onError) {
        print("insertion error${onError}");
        emit(NotesInsertionError());
      });
      return Future(() {});
    }).then((value) {
      emit(NotesInsertionSuccess());
      getIntoNotes(database: notesDataBase, date: getDate);
    }).catchError((onError) {
      emit(NotesInsertionError());
    });
  }
  String ?arabicDate;

  getArabicDate(String date)async{
    final translator = GoogleTranslator();

  await  translator.translate(date ,to: 'ar',).then((value) {
      arabicDate= value.text;

      emit(ArabicDate());
    });
  }
  String ?englishDate;

  getEnglishDate(String date){
    final translator = GoogleTranslator();

    translator.translate(date ,to: 'en').then((value) {
      englishDate= value.text;
      emit(EnglishDate());
    });

  }

  getIntoHealth({required String date, required Database database}) async {
    final translator = GoogleTranslator();
  String ?arabicDate;
  translator.translate(date ,to: 'ar').then((value) {
    arabicDate= value.text;
    print(arabicDate);
    emit(ArabicDate());
    database!.rawQuery('SELECT * FROM health  WHERE date =? AND status=?',
        ["$arabicDate", "new"]).catchError((onError) {
      print(onError);
      emit(healthGetDataError());
    }).then((value) {
      newTasks = [];
      value.forEach((element) {

        newTasks.add(element);
      });

      print(newTasks);
      emit(healthGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM health  WHERE date = ? AND status=?',
        ["$date", "done"]).catchError((onError) {
      print(onError);
      emit(healthGetDataError());
    }).then((value) {
      doneTasks = [];
      value.forEach((element) {
        doneTasks.add(element);
      });

      print(archivedTasks);
      emit(healthGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM health  WHERE date = ? AND status=?',
        ["$date", "deleted"]).catchError((onError) {
      print(onError);
      emit(healthGetDataError());
    }).then((value) {
      archivedTasks = [];
      value.forEach((element) {
        archivedTasks.add(element);
      });

      print(archivedTasks);
      emit(healthGetDataSuccess());
    });
  });
 //  String? englishDate;
 //  translator.translate(date ,to: 'en').then((value) {
 //    englishDate=value.text;
 //    emit(EnglishDate());
 //  });
 // print(englishDate);


  }

  getIntoWork({required String date, required Database database}) async {
    database!.rawQuery('SELECT * FROM work  WHERE date IN( ?,?) AND status=?',
        ["$date","٢٧", "new"]).catchError((onError) {
      print(onError);
      emit(workGetDataError());
    }).then((value) {
      newTasks = [];
      value.forEach((element) {
        newTasks.add(element);
      });

      print(newTasks);
      emit(workGetDataSuccess());
    });
    database!.rawQuery(
        'SELECT * FROM work  WHERE date = ? AND status=?', ["$date"," archived"]
    ).catchError((onError){
      print(onError);
      emit(workGetDataError());
    }).then((value) {
      archivedTasks=[];
      value.forEach((element) {
        archivedTasks.add(element);
      });

      print(archivedTasks);
      emit(workGetDataSuccess());
    });
    database!.rawQuery(
        'SELECT * FROM work  WHERE date = ? AND status=?', ["$date","done"]
    ).catchError((onError){
      print(onError);
      emit(workGetDataError());
    }).then((value) {
      doneTasks=[];
      value.forEach((element) {
        doneTasks.add(element);
      });

      print(doneTasks);
      emit(workGetDataSuccess());
    });
  }

  getIntoReligious({required String date, required Database database}) async {
    database!.rawQuery('SELECT * FROM religious  WHERE date = ? AND status=?',
        ["$date", "new"]).catchError((onError) {
      print(onError);
      emit(religiousGetDataError());
    }).then((value) {
      newTasks = [];
      value.forEach((element) {
        newTasks.add(element);
      });

      print(newTasks);
      emit(religiousGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM religious  WHERE date = ? AND status=?',
        ["$date", "done"]).catchError((onError) {
      print(onError);
      emit(religiousGetDataError());
    }).then((value) {
      archivedTasks = [];
      value.forEach((element) {
        archivedTasks.add(element);
      });

      print(archivedTasks);
      emit(religiousGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM religious  WHERE date = ? AND status=?',
        ["$date", "deleted"]).catchError((onError) {
      print(onError);
      emit(religiousGetDataError());
    }).then((value) {
      doneTasks = [];
      value.forEach((element) {
        doneTasks.add(element);
      });

      print(doneTasks);
      emit(religiousGetDataSuccess());
    });
  }

  getIntoFamily({required String date, required Database database}) async {
    database!.rawQuery('SELECT * FROM family  WHERE date = ? AND status=?',
        ["$date", "new"]).catchError((onError) {
      print(onError);
      emit(familyGetDataError());
    }).then((value) {
      newTasks = [];
      value.forEach((element) {
        newTasks.add(element);
      });

      print(newTasks);
      emit(familyGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM family  WHERE date = ? AND status=?',
        ["$date", "done"]).catchError((onError) {
      print(onError);
      emit(familyGetDataError());
    }).then((value) {
      archivedTasks = [];
      value.forEach((element) {
        archivedTasks.add(element);
      });

      print(archivedTasks);
      emit(familyGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM family  WHERE date = ? AND status=?',
        ["$date", "deleted"]).catchError((onError) {
      print(onError);
      emit(familyGetDataError());
    }).then((value) {
      doneTasks = [];
      value.forEach((element) {
        doneTasks.add(element);
      });

      print(doneTasks);
      emit(familyGetDataSuccess());
    });
  }
  getIntoHopies({required String date, required Database database}) async {
    database!.rawQuery('SELECT * FROM hoppies  WHERE date = ? AND status=?',
        ["$date", "new"]).catchError((onError) {
      print(onError);
      emit(hopiesGetDataError());
    }).then((value) {
      newTasks = [];
      value.forEach((element) {
        newTasks.add(element);
      });

      print(newTasks);
      emit(hopiesGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM hoppies  WHERE date = ? AND status=?',
        ["$date", "done"]).catchError((onError) {
      print(onError);
      emit(hopiesGetDataError());
    }).then((value) {
      archivedTasks = [];
      value.forEach((element) {
        archivedTasks.add(element);
      });

      print(archivedTasks);
      emit(hopiesGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM hoppies  WHERE date = ? AND status=?',
        ["$date", "deleted"]).catchError((onError) {
      print(onError);
      emit(hopiesGetDataError());
    }).then((value) {
      doneTasks = [];
      value.forEach((element) {
        doneTasks.add(element);
      });

      print(doneTasks);
      emit(hopiesGetDataSuccess());
    });
  }
  getIntoNotes({required String date, required Database database}) async {
    database!.rawQuery('SELECT * FROM notes  WHERE date = ? AND status=?',
        ["$date", "new"]).catchError((onError) {
      print(onError);
      emit(notesGetDataError());
    }).then((value) {
      newTasks = [];
      value.forEach((element) {
        newTasks.add(element);
      });

      print(newTasks);
      emit(notesGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM notes  WHERE date = ? AND status=?',
        ["$date", "done"]).catchError((onError) {
      print(onError);
      emit(notesGetDataError());
    }).then((value) {
      archivedTasks = [];
      value.forEach((element) {
        archivedTasks.add(element);
      });

      print(archivedTasks);
      emit(notesGetDataSuccess());
    });
    database!.rawQuery('SELECT * FROM notes  WHERE date = ? AND status=?',
        ["$date", "deleted"]).catchError((onError) {
      print(onError);
      emit(notesGetDataError());
    }).then((value) {
      doneTasks = [];
      value.forEach((element) {
        doneTasks.add(element);
      });

      print(doneTasks);
      emit(notesGetDataSuccess());
    });
  }
  updateHealth({required Database database,required int index,required String status,required String choosedDate}){
     database.rawUpdate(
        'UPDATE health SET status = ? WHERE id = ?',
        ['$status', '$index'])
         .then((value) {
           getIntoHealth(date: choosedDate, database: database);
           emit(healthUpDateDataSuccess());
     }).catchError((onError){
       emit(healthUpDateDataError());
     });


  }
  updateWork({required Database database,required int index,required String status,required String choosedDate}){
    database.rawUpdate(
        'UPDATE work SET status = ? WHERE id = ?',
        ['$status', '$index'])
        .then((value) {

      emit(workUpDateDataSuccess());
      getIntoWork(date: choosedDate, database: database);
    }).catchError((onError){
      emit(workUpDateDataError());
    });


  }
  updateReligious(){}
  updateFamily(){}
  updateHopies(){}
  updateNotes(){}
  deleteGym(){}
  deleteWork(){}
  deleteReligious(){}
  deleteFood(){}
  deleteHopies(){}
  deleteNotes(){}
}
