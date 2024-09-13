class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? profileImage;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profileImage'],
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
