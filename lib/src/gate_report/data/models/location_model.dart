import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.latitude,
    required super.longitude,
    required super.location,
  });

  const LocationModel.empty()
      : this(
          latitude: 0,
          longitude: 0,
          location: '',
        );

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? location,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
    );
  }

  LocationModel.fromMap(DataMap map)
      : super(
          latitude: map['latitude'] as double,
          longitude: map['longitude'] as double,
          location: map['location'] as String,
        );

  DataMap toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
    };
  }
}
