class BeastieCollection {
  final int beastieCollectionID;
  final int beastieID;
  final String beastieName;
  final String imagePath;
  final String type;

  BeastieCollection(
      {required this.beastieCollectionID,
      required this.beastieID,
      required this.beastieName,
      required this.imagePath,
      required this.type});
  factory BeastieCollection.fromMap(Map<String, dynamic> data) {
    return BeastieCollection(
        beastieCollectionID: data['beastieCollectionID'] ?? '',
        beastieID: data['beastieID'] ?? 1,
        beastieName: data['beastieName'] ?? 'blob1',
        imagePath: data['filePath'] ?? './assets/images/beasties/blob1.png',
        type: data['type'] ?? 'Blob');
  }
}
