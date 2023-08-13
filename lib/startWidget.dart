import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/states.dart';
import 'package:untitled4/constants.dart';
import 'package:untitled4/homeScreen.dart';
import 'package:untitled4/layout.dart';
import 'package:untitled4/sharedprefrences.dart';

class StartWidget extends StatelessWidget {
  StartWidget({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoBloc, ToDoStates>(
        listener: (context, stats) {
          if(stats is changeNameSuccess){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen()),
                    (route) => false);
          }
        },
        builder: (context, stats) {
          var cubit=ToDoBloc.get(context);
          return Scaffold(
            body: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'What\'s your name bestie ?',
                              style: TextStyle(
                                  color: Colors.blueGrey[500], fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 45,
                              width: 300,
                              child: TextFormField(
                                controller: nameController,
                                validator: (String? value) {
                                  if (value.toString().isEmpty) {
                                    return 'can\'t Skip';
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                        gapPadding: 10,
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                              CacheHelper.setData(key: 'name', value: nameController.text)
                                  .then((value) async{
                                    name=await CacheHelper.getData(key: 'name');
                                CacheHelper.setData(key: 'Known', value: true)
                                    .then((value) {
                                cubit.changeName(nameController.text);

                                });
                              });
                        }
                      },
                      child: Icon(Icons.arrow_forward),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
