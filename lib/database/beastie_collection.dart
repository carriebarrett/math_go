import 'package:firebase_database/firebase_database.dart';
import 'package:math_go/models/beastie_collection_model.dart';

class BeastieCollectionsData {
  final _database = FirebaseDatabase.instance.ref();
  final List<BeastieCollection> allCollections = [];

  // This will return all beastie collections
  Future<List<BeastieCollection>> getCollections() async {
    DataSnapshot collectionSnapshot = await getSnapshot();
    (collectionSnapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
      final beastieCollection = BeastieCollection.fromMap(value);
      allCollections.add(beastieCollection);
    });
    return allCollections;
  }

  Future<DataSnapshot> getSnapshot() async {
    return await _database.child('/BeastieCollection').get();
  }

  Future<DataSnapshot> getSingleSnapshot(String id) async {
    return await _database.child('/BeastieCollection/$id').get();
  }

  // Updates a specific collection with a new beastie
  Future<void> updateCollection(String collectionId, int beastieId) async {
    DataSnapshot collectionSnapshot = await getSingleSnapshot(collectionId);
    final BeastieCollection beastieCollection = BeastieCollection.fromMap(
        (collectionSnapshot.value as Map<dynamic, dynamic>));
    await _database.child('/BeastieCollection/$collectionId').update({
      'beastieIDs': [...beastieCollection.beastiesIds, beastieId].toString()
    });
  }
}
