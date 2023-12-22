import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.name,
    required super.urgentLetter,
    required super.documentation,
  });

  const ReportModel.empty()
      : this(
          name: '',
          urgentLetter: '',
          documentation: '',
        );

  ReportModel copyWith({
    String? name,
    String? urgentLetter,
    String? documentation,
  }) {
    return ReportModel(
      name: name ?? this.name,
      urgentLetter: urgentLetter ?? this.urgentLetter,
      documentation: documentation ?? this.documentation,
    );
  }

  ReportModel.fromMap(DataMap map)
      : super(
          name: map['name'] as String,
          urgentLetter: map['urgent_letter'] as String,
          documentation: map['documentation'] as String,
        );

  DataMap toMap() {
    return {
      'name': name,
      'urgent_letter': urgentLetter,
      'documentation': documentation,
    };
  }
}
