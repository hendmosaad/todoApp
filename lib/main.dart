import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translator/translator.dart';
import 'package:untitled4/Widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:untitled4/bloc/BlocObserver.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/blocB.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/constants.dart';
import 'package:untitled4/homeScreen.dart';
import 'package:untitled4/layout.dart';
import 'package:untitled4/sharedprefrences.dart';
import 'package:untitled4/startWidget.dart';
import 'generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initShared();
  final translator = GoogleTranslator();
  Map map={'1':'1','2':'22'};
  String date='1/5/1998';
  print(replaceFarsiNumber(date));
  bool Known = false;
  name = await CacheHelper.getData(key: 'name')??'';
  Known = await CacheHelper.getData(key: 'Known') != null ? true : false;
  print(Known);
  Widget startWidget = LayOut();
  if (Known == false) {
    startWidget = StartWidget();
  } else {
    startWidget = HomeScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ToDoBloc()..healthDataBase()..workDataBase()..notesDataBase()..hoppiesDataBase()..religiousDataBase()..familyDataBase()),
        BlocProvider(create: (BuildContext context) => ToDoBlocB())
      ],
      child: BlocConsumer<ToDoBloc, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =ToDoBloc.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,

            ],
            locale: Locale('${cubit.lang}'),
            supportedLocales: S.delegate.supportedLocales,
            title: 'Flutter Demo',
            home: startWidget,
          );
        },
      ),
    );
  }
}
