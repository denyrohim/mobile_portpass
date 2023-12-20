import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.role,
    super.profileImg,
    super.location,
    super.latitude,
    super.longitude,
  });

  const LocalUserModel.empty()
      : this(
          id: 1,
          email: 'testing@admin.com',
          name: 'testing',
          role: 'employee',
          profileImg: null,
          location: null,
          latitude: 0,
          longitude: 0,
        );

  LocalUserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? role,
    String? profileImg,
    String? location,
    double? latitude,
    double? longitude,
  }) {
    return LocalUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImg: profileImg ?? this.profileImg,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  LocalUserModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          email: map['email'] as String,
          name: map['name'] as String,
          role: map['role'] as String,
          profileImg: map['profile_img'] as String?,
          location: map['location'] as String?,
          latitude: map['latitude'] as double?,
          longitude: map['longitude'] as double?,
        );

  DataMap toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profile_img': profileImg,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
