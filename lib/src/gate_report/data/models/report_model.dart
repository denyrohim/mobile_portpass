import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.location,
    required super.urgentLetter,
    required super.documentation,
    required super.dateTime,
  });

  ReportModel.empty()
      : this(
          location: '',
          urgentLetter: '',
          documentation: '',
          dateTime: DateTime.now(),
        );

  ReportModel copyWith({
    String? location,
    String? urgentLetter,
    String? documentation,
    DateTime? dateTime,
  }) {
    return ReportModel(
      location: location ?? this.location,
      urgentLetter: urgentLetter ?? this.urgentLetter,
      documentation: documentation ?? this.documentation,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  ReportModel.fromMap(DataMap map)
      : super(
          location: map['location'] as String,
          urgentLetter: map['urgent_letter'] as String,
          documentation: map['documentation'] as String,
          dateTime: map['date_time'] as DateTime,
        );

  DataMap toMap() {
    return {
      'location': location,
      'urgent_letter': urgentLetter,
      'documentation': documentation,
      'date_time': dateTime,
    };
  }
}
