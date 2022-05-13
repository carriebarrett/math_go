import 'package:firebase_database/firebase_database.dart';
import 'package:math_go/database/beastie_collection_model.dart';

class BeastieCollStreemPub {
  final _database = FirebaseDatabase.instance.ref();

  // This will return the entire collection of all users beastie collections and data
  Stream<List<BeastieCollection>> getCollectionStream() {
    final collectionStream = _database.child('/BeastieCollection').onValue;
    final results = collectionStream.map((event) {
      final collectionMap = Map<String, dynamic>.from(event.snapshot.value);
      final collectionList = collectionMap.entries.map((e) {
        return BeastieCollection.fromMap(Map<String, dynamic>.from(e.value));
      }).toList();
      return collectionList;
    });
    return results;
  }
}
