import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String location;
  final String urgentLetter;
  final String documentation;
  final DateTime dateTime;

  const Report({
    required this.location,
    required this.urgentLetter,
    required this.documentation,
    required this.dateTime,
  });

  Report.empty()
      : this(
          location: '',
          urgentLetter: '',
          documentation: '',
          dateTime: DateTime.now(),
        );

  @override
  List<Object?> get props => [
        location,
        urgentLetter,
        documentation,
        dateTime,
      ];
}
