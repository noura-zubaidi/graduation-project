class User {
  String? uid;
  String? name;
  String? email;
  String? password;

  User({this.uid, this.name, this.password, this.email});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'email': email, 'password': password};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
