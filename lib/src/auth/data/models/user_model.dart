import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required int id,
    required String email,
    required String name,
    required String role,
    String? profileImg,
  }) : super(
          id: id,
          email: email,
          name: name,
          role: role,
          profileImg: profileImg,
        );

  const LocalUserModel.empty()
      : this(
          id: -99,
          email: '',
          name: '',
          role: '',
          profileImg: '',
        );

  LocalUserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? profileImg,
  }) {
    return LocalUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImg: profileImg ?? this.profileImg,
    );
  }

  LocalUserModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          email: map['email'] as String,
          name: map['name'] as String,
          role: map['role'] as String,
          profileImg: map['profile_img'] as String?,
        );

  DataMap toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profile_img': profileImg,
    };
  }
}
