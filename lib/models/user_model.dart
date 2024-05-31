class User {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? image;
  int? readingChallenge;

  User({
    this.uid,
    this.name,
    this.password,
    this.email,
    this.image,
    this.readingChallenge,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'readingChallenge': readingChallenge,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      image: map['image'],
      readingChallenge: map['readingChallenge'],
    );
  }
}
