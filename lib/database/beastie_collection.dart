import 'package:firebase_database/firebase_database.dart';
import 'package:math_go/database/beastie_collection_model.dart';

class BeastieCollStreemPub {
  final _database = FirebaseDatabase.instance.ref();
  final List<BeastieCollection> list = [];

  // This will return the entire collection of all users beastie collections and data
  getCollectionStream() async {
    final collectionStream = await _database.child('/BeastieCollection').get();
    final map = collectionStream.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final beastie = BeastieCollection.fromMap(value);
      list.add(beastie);
    });
  }
}
