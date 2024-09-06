class UserModel {
  final String name;
  final String email;
  final String phone;

  UserModel(this.name, this.email, this.phone);

  factory UserModel.fromJson(json) {
    return UserModel(
      json['name'],
      json['email'],
      json['phone'],
    );
  }
}
