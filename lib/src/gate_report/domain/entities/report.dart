import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String urgentLetter;
  final String documentation;
  final DateTime dateTime;

  const Report({
    required this.urgentLetter,
    required this.documentation,
    required this.dateTime,
  });

  Report.empty()
      : this(
          urgentLetter: '',
          documentation: '',
          dateTime: DateTime.now(),
        );

  @override
  List<Object?> get props => [
        urgentLetter,
        documentation,
        dateTime,
      ];
}
