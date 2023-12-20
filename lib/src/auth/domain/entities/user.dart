import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profileImg,
    this.location,
    this.latitude,
    this.longitude,
  });

  const LocalUser.empty()
      : id = 1,
        email = 'testing@admin.com',
        name = 'testing',
        role = 'employee',
        profileImg = '',
        location = '',
        latitude = 0,
        longitude = 0;

  final int id;
  final String email;
  final String name;
  final String role;
  final String? profileImg;
  final String? location;
  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props =>
      [id, name, email, profileImg, location, role, latitude, longitude];

  @override
  String toString() {
    return 'LocalUser{id: $id, email: $email,'
        ' role: $role,'
        ' name: $name, profileImg: $profileImg, location: $location}'
        ' latitude: $latitude, longitude: $longitude';
  }
}
