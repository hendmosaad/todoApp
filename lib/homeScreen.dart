import 'package:bloc/bloc.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/constants.dart';
import 'package:untitled4/generated/l10n.dart';
import 'package:untitled4/layout.dart';
import 'package:untitled4/sharedprefrences.dart';
import 'package:untitled4/startWidget.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   //

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ToDoBloc,ToDoStates>(
    listener: (context,state){},
    builder: (context,state){
      var cubit=ToDoBloc.get(context);
      return Scaffold(
        key: scaffoldKey,

        backgroundColor: Colors.purple[900],
        drawer: Drawer(

          child: Container(
            padding: EdgeInsetsDirectional.symmetric(vertical: 100,horizontal: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StartWidget()));
                  },
                  child: Row(
                    children: [
                      Text('Edit your name',style: TextStyle(color: Colors.purple[900]),),
                      Spacer(),
                      Icon(Icons.edit,color: Colors.grey[400],)
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                   showContextMenu(
                       Offset(5, 10),
                       context,
                       (context) =>
                       [
                         ListTile(
                           title: Text('arabic'),
                           onTap: () {
                            CacheHelper.setData(key: 'lang', value: 'ar')
                                .then((value) {
                                  print('language cached ');
                              cubit.cahngeLang('ar');
                            });
                           },
                         ),
                         Container(height: 1,width: double.infinity,color: Colors.grey[200],),
                         ListTile(
                           title: Text('english'),
                           onTap: () {
                             CacheHelper.setData(key: 'lang', value: 'en')
                                 .then((value) {
                               print('language cached ');
                               cubit.cahngeLang('en');
                             });

                             },
                         ),
                         SizedBox(height: 10,),
                       ]
                       ,
                      8.5, 255.5);
                  },
                  child: Row(
                    children: [
                      Text('change language',style: TextStyle(color: Colors.purple[900]),),
                Spacer(),
                Icon(Icons.language,color: Colors.grey[400],)
              ],
            ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.purple[900],
          leading:IconButton(
            onPressed: (){
              scaffoldKey.currentState!.openDrawer();
              // cubit.createDataBase();
            },
            icon: Icon(Icons.menu),
          ),
        ),
        body:SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple[900],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('${S.of(context).title} ,${cubit.name??name}',style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: AutofillHints.addressState
                    ),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width:double.infinity,
                  height: 900,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(20),topStart: Radius.circular(20))

                  ),
                  child:
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        List addresses=cubit.getAddresses(context);
                      return  CategoryItem(index, context,addresses);
                      }
                      , separatorBuilder:(contxt,index)=> SizedBox(height: 20,), itemCount: 6),
                )
              ],
            )),
      );
    },
  );
  }
  Widget CategoryItem(index,context,List addreses){
    return InkWell(
      onTap: (){
         CacheHelper.setData(key: 'index', value: index)
             .then((value)async{
               index= await CacheHelper.getData(key: 'index');
               ToDoBloc.get(context).changeCategoryIndex(index);
               switch (index){
                 case 0:{
                   ToDoBloc.get(context)..getIntoWork(date: DateFormat.yMMMd().format(DateTime.now()), database: ToDoBloc.get(context).workDatabase!);
                 }
                 case 1:{
                   ToDoBloc.get(context)..getIntoHealth(date: DateFormat.yMMMd().format(DateTime.now()), database: ToDoBloc.get(context).healthDatabase!);

                 }
                 case 2:{
                   ToDoBloc.get(context)..getIntoReligious(date: DateFormat.yMMMd().format(DateTime.now()), database: ToDoBloc.get(context).religiousDatabase!);

                 }
                 case 3:{
                   ToDoBloc.get(context).getIntoHopies(date: DateFormat.yMMMd().format(DateTime.now()), database: ToDoBloc.get(context).hopiesDatabase!);

                 }
                 case 4:{
                   ToDoBloc.get(context).getIntoNotes(date: DateFormat.yMMMd().format(DateTime.now()), database: ToDoBloc.get(context).notesDatabase!);

                 }
                 case 5:{
                   ToDoBloc.get(context).getIntoFamily(date: DateFormat.yMMMd().format(DateTime.now()), database: ToDoBloc.get(context).familyDatabase!);

                 }
               }

               Navigator.push(context, MaterialPageRoute(builder: (context)=>LayOut()));
         });
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(15),topStart: Radius.circular(15),bottomStart: Radius.circular(15),bottomEnd: Radius.circular(15))
          ),
          child: Row(
            children: [
              Text('${addreses[index]}',style: TextStyle(fontSize: 18,color: Colors.grey),),
              Spacer(),
              Image(image: AssetImage('${ToDoBloc.get(context).images[index]}'))
            ],
          ),
        ),
      ),
    );
  }
}
