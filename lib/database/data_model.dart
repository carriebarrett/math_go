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
  factory BeastieCollection.fromMap(Map data) {
    return BeastieCollection(
        beastieCollectionID: data['beastieCollectionID'] ?? '',
        beastieID: data['beastieID'] ?? 1,
        beastieName: data['beastieName'] ?? 'blob1',
        imagePath: data['imagePath'] ?? './assets/images/beasties/leaf7.png',
        type: data['type'] ?? 'Blob');
  }
}

class Math {
  final int mathID;
  final int grade;
  final int questionNumber;
  final String problem;
  final String answer;

  Math(
      {required this.mathID,
      required this.grade,
      required this.questionNumber,
      required this.problem,
      required this.answer});
  factory Math.fromMap(Map data) {
    return Math(
        mathID: data['mathID'] ?? 01,
        grade: data['grade'] ?? 1,
        questionNumber: data['questionNumber'] ?? 1,
        problem: data['problem'] ?? '2 + 2',
        answer: data['answer'] ?? '4');
  }
}

class Beastie {
  final int beastieID;
  final String name;
  final String imagePath;
  final String type;
  final String math;

  Beastie({
    required this.beastieID,
    required this.name,
    required this.imagePath,
    required this.type,
    required this.math,
  });
  factory Beastie.fromMap(Map data) {
    return Beastie(
        beastieID: data['beastieID'] ?? 1,
        name: data['name'] ?? 'blob1',
        imagePath: data['imagePath'] ?? './assets/images/beasties/leaf7.png',
        type: data['type'] ?? 'Blob',
        math: data['math'] ?? '/math');
  }
}
