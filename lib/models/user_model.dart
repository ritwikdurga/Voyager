class UserModel {
  final String? name;
  final String? uid;
  final String? email;
  final String? creationTime;
  final String? photoURL;
  UserModel(this.name, this.email, this.uid, this.creationTime, this.photoURL);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'creationTime': creationTime,
      'photoURL': photoURL,
    };
  }
}
