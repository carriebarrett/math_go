import 'package:firebase_database/firebase_database.dart';
import 'package:math_go/models/beastie_model.dart';

class BeastiesData {
  final _database = FirebaseDatabase.instance.ref();

  final List<Beastie> beasties = [];

  // This will return all beasties
  Future<List<Beastie>> getBeasties() async {
    DataSnapshot collectionSnapshot = await getSnapshot();
    (collectionSnapshot.value as List<Object?>?)?.forEach(makeBeastie);
    return beasties;
  }

  void makeBeastie(value) {
    if (value == null) {
      return;
    }
    final beastie = Beastie.fromMap(value);
    beasties.add(beastie);
  }

  Future<DataSnapshot> getSnapshot() async {
    return await _database.child('/AllBeasties').get();
  }
}
