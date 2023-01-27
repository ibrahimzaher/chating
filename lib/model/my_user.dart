class MyUser {
  static const String collectionName = 'users';
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  MyUser(
      {required this.email,
      required this.userName,
      required this.lastName,
      required this.id,
      required this.firstName});
  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          userName: json['userName'],
          firstName: json['firstName'],
          lastName: json['lastName'],
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
      };
}
