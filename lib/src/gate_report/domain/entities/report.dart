import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String name;
  final String urgentLetter;
  final String documentation;

  const Report({
    required this.name,
    required this.urgentLetter,
    required this.documentation,
  });

  const Report.empty()
      : this(
          name: '',
          urgentLetter: '',
          documentation: '',
        );

  @override
  List<Object?> get props => [
        name,
        urgentLetter,
        documentation,
      ];
}
