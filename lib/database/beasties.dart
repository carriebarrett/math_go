import 'package:firebase_database/firebase_database.dart';
import 'package:math_go/database/beastie_model.dart';

class BeastieStreamPub {
  final _database = FirebaseDatabase.instance.ref();

  final List<Beastie> list = [];

  // This will return the entire collection of all users beastie collections and data
  getCollection() async {
    final beastieStream = await _database.child('/AllBeasties').get();
    final map = beastieStream.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final beastie = Beastie.fromMap(value);
      list.add(beastie);
    });
  }
}
