import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.urgentLetter,
    required super.documentation,
    required super.dateTime,
  });

  ReportModel.empty()
      : this(
          urgentLetter: '',
          documentation: '',
          dateTime: DateTime.now(),
        );

  ReportModel copyWith({
    String? urgentLetter,
    String? documentation,
    DateTime? dateTime,
  }) {
    return ReportModel(
      urgentLetter: urgentLetter ?? this.urgentLetter,
      documentation: documentation ?? this.documentation,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  ReportModel.fromMap(DataMap map)
      : super(
          urgentLetter: map['urgent_letter'] as String,
          documentation: map['documentation'] as String,
          dateTime: map['date_time'] as DateTime,
        );

  DataMap toMap() {
    return {
      'urgent_letter': urgentLetter,
      'documentation': documentation,
      'date_time': dateTime,
    };
  }
}
