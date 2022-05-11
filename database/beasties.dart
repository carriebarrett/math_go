import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BeastieCollection extends StatelessWidget {
  BeastieCollection({Key? key}) : super(key: key);
  final database = FirebaseDatabase.instance.ref();

  // Need user Auth ID
  String get userID => '1';

  @override
  Widget build(BuildContext context) {
    final setStream = database.child('/users/' + userID + '/beastieCollection');

    // Examples of beasties added to collection
    setStream.set({
      'beastieID': 1,
      'name': 'blob1',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });

    setStream.set({
      'beastieID': 2,
      'name': 'blob2',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });

    setStream.set({
      'beastieID': 3,
      'name': 'blob3',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });
    setStream.set({
      'beastieID': 4,
      'name': 'blob4',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });
    setStream.set({
      'beastieID': 5,
      'name': 'blob5',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });
    setStream.set({
      'beastieID': 6,
      'name': 'blob6',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });
    setStream.set({
      'beastieID': 7,
      'name': 'blob7',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });
    setStream.set({
      'beastieID': 8,
      'name': 'blob8',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });
    setStream.set({
      'beastieID': 9,
      'name': 'blob9',
      'filename': './assets/images/beasties/leaf7.png',
      'type': 'Blob'
    });

    return BeastieCollection();
  }
}
