import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;
  final String location;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  const Location.empty()
      : this(
          latitude: 0,
          longitude: 0,
          location: '',
        );

  @override
  List<Object?> get props => [latitude, longitude, location];
}
