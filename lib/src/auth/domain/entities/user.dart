import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profileImg,
  });

  const LocalUser.empty()
      : id = -99,
        email = '',
        name = '',
        role = '',
        profileImg = '';

  final int id;
  final String email;
  final String name;
  final String role;
  final String? profileImg;

  @override
  List<Object?> get props => [id, email];

  @override
  String toString() {
    return 'LocalUser{id: $id, email: $email,'
        ' role: $role,'
        ' name: $name, profileImg: $profileImg}';
  }
}
