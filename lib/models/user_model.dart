class User {
  final int userID;
  final String email;
  final String password;
  final int collectionID;

  User(
      {required this.userID,
      required this.email,
      required this.password,
      required this.collectionID});

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
        userID: data['userID'] ?? 01,
        email: data['email'] ?? 'email.mail',
        password: data['password'] ?? 'password',
        collectionID: data['collectionID'] ?? 01);
  }
}
