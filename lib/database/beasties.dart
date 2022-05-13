import 'package:firebase_database/firebase_database.dart';
import 'package:math_go/database/beastie_collection_model.dart';
import 'package:math_go/database/beastie_model.dart';

class BeastieStreamPub {
  final _database = FirebaseDatabase.instance.ref();

  // This will return the entire collection of all users beastie collections and data
  Stream<List<Beastie>> getCollectionStream() {
    final beastieStream = _database.child('/AllBeasties').onValue;
    final results = beastieStream.map((event) {
      final beastieMap = Map<String, dynamic>.from(event.snapshot.value);
      final beastieList = beastieMap.entries.map((e) {
        return Beastie.fromMap(Map<String, dynamic>.from(e.value));
      }).toList();
      return beastieList;
    });
    return results;
  }
}
