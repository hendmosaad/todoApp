import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled4/bloc/BlocBstates.dart';
import 'package:untitled4/bloc/bloc.dart';
import 'package:untitled4/bloc/states.dart';
class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoBloc,ToDoStates>(
      listener: (context,states){},
      builder: (context,states){
        var cubit=ToDoBloc.get(context);
        return Scaffold(
          backgroundColor: Colors.white54,
          body: ListView.separated(
              itemBuilder: (context,index)=>taskItem(context, index, ToDoBloc.get(context)),
              separatorBuilder: (context,index)=> SizedBox(height: 10,),
              itemCount: cubit.doneTasks.length-1)

        );
      },
    );
  }

  Widget taskItem(context,index,cubit)=>Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [


      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${cubit.newTasks[index]['text']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black87, fontSize: 18),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              '16 may 16:00',
              style: TextStyle(
                  color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 20,
      ),
      IconButton(
          onPressed: () {}, icon: Icon(Icons.archive_outlined,color: Colors.pink[200],)),
      IconButton(
          onPressed: () {}, icon: Icon(Icons.delete,color: Colors.pink[200],)),
    ],
  );
}
