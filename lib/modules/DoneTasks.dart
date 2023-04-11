import 'package:flutter/cupertino.dart';

class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('DONE TASKS',
        style: TextStyle(
            fontSize: 50
        ),),
    );
  }
}
