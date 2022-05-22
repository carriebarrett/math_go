class User {
  final String userID;
  final String email;
  final String beastieCollectionID;

  User(
      {required this.userID,
      required this.email,
      required this.beastieCollectionID});

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
        userID: data['userID'] ?? 01,
        email: data['email'] ?? 'email.mail',
        beastieCollectionID: data['collectionID'] ?? 01);
  }
}
