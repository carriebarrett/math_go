import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

//https://www.youtube.com/watch?v=sXBJZD0fBa4&ab_channel=Firebase

class WriteDatabase extends StatefulWidget {
  const WriteDatabase({Key? key, required this.title}) : super(key: key);
  final String title;
  static const routeName = 'writeData';

  @override
  _DatabaseService createState() => _DatabaseService();
}

class _DatabaseService extends State<WriteDatabase> {
  final database = FirebaseDatabase.instance.ref();

  // This will work if copied into main.dart, unsure how to get it to work form another screen
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await database.child('/beasties').set({
        'beastieID': 1,
        'name': 'Blob1',
        'imagePath': '',
        'type': 'Blob',
        'math': '/Math/1/1'
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
      ),
      body: const Text("test"),
    );
  }
}
