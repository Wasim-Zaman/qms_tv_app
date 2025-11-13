class UserModel {
  final String id;
  final String email;
  final String name;
  final String deptcode;
  final String createdAt;
  final String updatedAt;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.deptcode,
    required this.createdAt,
    required this.updatedAt,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      deptcode: json['deptcode'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'deptcode': deptcode,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? deptcode,
    String? createdAt,
    String? updatedAt,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      deptcode: deptcode ?? this.deptcode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
