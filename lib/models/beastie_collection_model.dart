import 'package:math_go/models/beastie_model.dart';

class BeastieCollection {
  final int beastieCollectionID;
  final List<Beastie> beasties;

  BeastieCollection(
      {required this.beastieCollectionID, required this.beasties});

  factory BeastieCollection.fromMap(Map<dynamic, dynamic> data) {
    return BeastieCollection(
        beastieCollectionID: data['beastieCollectionID'] ?? 1,
        beasties: data['beastieIDs'] ?? []);
  }
}
