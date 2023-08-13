import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:untitled4/sharedprefrences.dart';

class NewTasks extends StatefulWidget {
  NewTasks({Key? key}) : super(key: key);

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  bool isOpen = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoBloc, ToDoStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = ToDoBloc.get(context);
        // cubit.changeName(function: cubit.getIntoWork(date: DateFormat.yMMMd().format(DateTime.now()), database: cubit.workDatabase!));
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.purple[900],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple[900],
                  ),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.grey[400]!,
                    selectedTextColor: Colors.white,
                    onDateChange: (date)async {
                    await  cubit.changeChoosedDate(comingDate: date);
                    // await  cubit.getArabicDate(DateFormat.yMd().format(cubit.choosedDate));
                    // await  cubit.getEnglishDate(DateFormat.yMd().format(cubit.choosedDate));
                    // print(cubit.arabicDate);
                    // print(cubit.englishDate);
                    print(DateFormat.yMd().format(cubit.choosedDate));
                   await  cubit.getArabicDate( DateFormat.yMMMd().format(cubit.choosedDate));

                      switch (cubit.currentCategoryIndex) {
                        case 0:
                          {
                            cubit.getIntoWork(
                                date: DateFormat.yMMMd()
                                    .format(cubit.choosedDate),
                                database: cubit.workDatabase!);
                          }
                        case 1:
                          {
                            cubit.getIntoHealth(
                                date: DateFormat.yMMMd()
                                    .format(cubit.choosedDate),
                                database: cubit.healthDatabase!);
                          }
                        case 2:
                          {
                            cubit.getIntoReligious(
                                date: DateFormat.yMMMd()
                                    .format(cubit.choosedDate),
                                database: cubit.religiousDatabase!);
                          }
                        case 3:
                          {
                            cubit.getIntoHopies(
                                date: DateFormat.yMMMd()
                                    .format(cubit.choosedDate),
                                database: cubit.hopiesDatabase!);
                          }
                        case 4:
                          {
                            cubit.getIntoNotes(
                                date: DateFormat.yMMMd()
                                    .format(cubit.choosedDate),
                                database: cubit.notesDatabase!);
                          }
                        case 5:
                          {
                            cubit.getIntoFamily(
                                date: DateFormat.yMMMd()
                                    .format(cubit.choosedDate),
                                database: cubit.familyDatabase!);
                          }
                      }
                    },
                    locale: 'en',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 900,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20),
                          topStart: Radius.circular(20))),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (contxt, index) {
                        cubit.newTasks.forEach((element) {
                          cubit.checks.add(false);
                        });

                        return taskItem(context, index, ToDoBloc.get(context));
                      },
                      separatorBuilder: (contxt, index) => SizedBox(
                            height: 20,
                          ),
                      itemCount: cubit.newTasks.length),
                )
              ],
            ),
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async {
                if (isOpen == false) {
                  scaffoldKey.currentState!.showBottomSheet(
                      (BuildContext context) => ButtomSheetWidget());
                  setState(() {
                    isOpen = true;
                  });
                } else {
                  if (formKey.currentState!.validate()) {
                    switch (cubit.currentCategoryIndex) {
                      case 0:
                        {
                          cubit
                              .insertIntoWork(
                                  workDataBase: cubit.workDatabase!,
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  getDate: DateFormat.yMMMd()
                                      .format(cubit.choosedDate))
                              .then((value) {
                            //   //
                            setState(() {
                              isOpen = false;
                            });
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      case 1:
                        {
                          cubit
                              .insertIntoHealth(
                                  getDate: DateFormat.yMMMd()
                                      .format(cubit.choosedDate),
                                  healthDataBase: cubit.healthDatabase!,
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text)
                              .then((value) {
                            setState(() {
                              isOpen = false;
                            });
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      case 2:
                        {
                          cubit
                              .insertIntoReligious(
                                  getDate: DateFormat.yMMMd()
                                      .format(cubit.choosedDate),
                                  religiousDataBase: cubit.religiousDatabase!,
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text)
                              .then((value) {
                            setState(() {
                              isOpen = false;
                            });
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      case 3:
                        {
                          cubit
                              .insertIntoHopies(
                                  getDate: DateFormat.yMMMd()
                                      .format(cubit.choosedDate),
                                  hopiesDataBase: cubit.hopiesDatabase!,
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text)
                              .then((value) {
                            setState(() {
                              isOpen = false;
                            });
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      case 4:
                        {
                          cubit
                              .insertIntoNotes(
                                  getDate: DateFormat.yMMMd()
                                      .format(cubit.choosedDate),
                                  notesDataBase: cubit.notesDatabase!,
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text)
                              .then((value) {
                            setState(() {
                              isOpen = false;
                            });
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      case 5:
                        {
                          cubit
                              .insertIntoFamily(
                                  getDate: DateFormat.yMMMd()
                                      .format(cubit.choosedDate),
                                  familyDataBase: cubit.familyDatabase!,
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text)
                              .then((value) {
                            setState(() {
                              isOpen = false;
                            });
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                    }
                  } else if (!formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    setState(() {
                      isOpen = false;
                    });

                    // });
                  }
                }
              },
              backgroundColor: Colors.purple[900],
              clipBehavior: Clip.antiAlias,
            ),
          ),
        );
      },
    );
  }

  Widget ButtomSheetWidget() => Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        child: Container(
          padding:
              EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 10),
          height: 300,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return validation;
                        }
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: 'title',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.type_specimen_outlined),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pink[200]!,
                              ),
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: TextFormField(
                      onTap: () {
                        showDatePicker(
                          locale: Locale('en'),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.utc(2024))
                            .then((value) {
                          dateController.text =
                              DateFormat.yMd().format(value!);

                        });
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return validation;
                        }
                      },
                      controller: dateController,
                      decoration: InputDecoration(
                          hintText: 'date',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.calendar_month),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pink[200]!,
                              ),
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: TextFormField(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 6, minute: 0),
                        ).then((value) {
                          timeController.text =
                              value!.format(context).toString();
                        });
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return validation;
                        }
                      },
                      controller: timeController,
                      decoration: InputDecoration(
                          hintText: 'time',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.hourglass_empty_rounded),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pink[200]!,
                              ),
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget taskItem(context, index, cubit) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: cubit.newTasks.length != 0 ? cubit.checks[index] : false,
            onChanged: (onChanged) {
              setState(() {
                cubit.checks[index] = !cubit.checks[index];
              });
              print('$index ${cubit.checks[index]}');
              if (cubit.checks[index] == true) {
                ToDoBloc.get(context).updateWork(
                    database: ToDoBloc.get(context).workDatabase!,
                    choosedDate: DateFormat.yMMMd()
                        .format(ToDoBloc.get(context).choosedDate!),
                    index: ToDoBloc.get(context).newTasks[index]['id'],
                    status: 'done');
              }
              setState(() {
                cubit.checks[index] = !cubit.checks[index];
              });
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${cubit.newTasks[index]['text']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${cubit.newTasks[index]['date']}',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.pink[200],
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.pink[200],
              )),
        ],
      );
}
