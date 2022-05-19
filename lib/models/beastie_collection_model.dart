import 'dart:convert';

class BeastieCollection {
  final String beastieCollectionID;
  final List<dynamic> beastiesIds;

  BeastieCollection(
      {required this.beastieCollectionID, required this.beastiesIds});

// You can't easily save lists in Firebase so I am saving the list of IDs as a string
// then decoding it to get it back into a list in the client
  factory BeastieCollection.fromMap(Map<dynamic, dynamic> data) {
    return BeastieCollection(
        beastieCollectionID: data['beastieCollectionID'] ?? "",
        beastiesIds: json.decode(data['beastieIDs']) ?? []);
  }
}
