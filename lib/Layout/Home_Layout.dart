import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/ArchivedTasks.dart';
import 'package:todo_app/modules/DoneTasks.dart';
import 'package:todo_app/modules/NewTasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late Database data ;
  int currentIndex = 0 ;
  List<Widget> screens = const [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];
  List<String> titles = const [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];

  bool isBottomSheetOpen = false;
  IconData fabIcon = Icons.edit;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: const TextStyle(
            fontSize: 25
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            insertDatabase();
            if(isBottomSheetOpen){
              Navigator.pop(context);
              isBottomSheetOpen = false;
              fabIcon = Icons.edit;
            }else{
              scaffoldKey.currentState?.showBottomSheet((context) => Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.blueGrey
                ),
              ));
              isBottomSheetOpen = true;
              fabIcon = Icons.add;
            }setState(() {
            });

          },
        child:  Icon(fabIcon),
      ),
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
    onTap: (myIndex){
          setState(() {
            currentIndex = myIndex ;
          });
    },
        items:const [
          BottomNavigationBarItem(
              icon: Icon(Icons.table_rows_rounded),
          label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check),
          label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
          label: 'Archived'),
        ],
      ),
      body: screens[currentIndex],
    );
  }


  void createDatabase() async {
    data =
    await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version)
        {
          print('database created');
          database.execute('CREATE TABLE TASKS (id INTEGER PRIMARY KEY, title TEXT , data TEXT, time TEXT,status TEXT)')
              .then((value){
            print('table created');
          }).catchError((error){
            print('table did not create ${error.toString()}');
          });
        },
        onOpen: (database){
          print('database opened');
        });
  }


  void insertDatabase(){
    data.transaction((txn) {
      txn.rawInsert('INSERT INTO Tasks(title, data, time , status) VALUES ("first", "2023", "5/26" , "one")');
      return null as Future;}

    ).then((value){
      print('inserted successfully');
    }).catchError((error){
      print('something went wrong ${error.toString()}');
    });
  }
}

























