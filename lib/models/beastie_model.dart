class Beastie {
  final int beastieID;
  final String name;
  final String imagePath;
  final String type;
  final String question;
  final String answer;

  Beastie(
      {required this.beastieID,
      required this.name,
      required this.imagePath,
      required this.type,
      required this.question,
      required this.answer});

  factory Beastie.fromMap(Map<dynamic, dynamic> data) {
    return Beastie(
        beastieID: data['beastieID'] ?? 1,
        name: data['name'] ?? 'blob1',
        imagePath: data['imagePath'] ?? './assets/images/beasties/leaf7.png',
        type: data['type'] ?? 'Blob',
        question: data['Question'] ?? '2 + 2',
        answer: data['Answer'] ?? '4');
  }
}
