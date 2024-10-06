class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;

  UserModel({this.uid, this.name, this.email, this.phoneNumber});

  factory UserModel.fromFirebase(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
    );
  }
}
